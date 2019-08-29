ACCESS_KEY=${1}
PUBLIC_IP=$(curl https://api.ipify.org/)

sed -i "s/YourHostname/`hostname -f`/" ~/spark.iot.py
sed -i "s/YourCDSWDomain/cdsw.${PUBLIC_IP}.nip.io/" ~/spark.iot.py
sed -i "s/YourAccessKey/${ACCESS_KEY}/" ~/spark.iot.py
wget  http://central.maven.org/maven2/org/apache/kudu/kudu-spark2_2.11/1.9.0/kudu-spark2_2.11-1.9.0.jar
wget https://raw.githubusercontent.com/swordsmanliu/SparkStreamingHbase/master/lib/spark-core_2.11-1.5.2.logging.jar
rm -rf ~/.m2 ~/.ivy2/
spark-submit --master local[2] --jars kudu-spark2_2.11-1.9.0.jar,spark-core_2.11-1.5.2.logging.jar --packages org.apache.spark:spark-streaming-kafka_2.11:1.6.3 ~/spark.iot.py
