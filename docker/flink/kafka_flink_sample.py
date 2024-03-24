################################################################################
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
# limitations under the License.
################################################################################
import logging
import sys

from pyflink.common import Types
from pyflink.datastream import StreamExecutionEnvironment
from pyflink.datastream.connectors.kafka import FlinkKafkaProducer, FlinkKafkaConsumer
from pyflink.datastream.formats.json import JsonRowSerializationSchema, JsonRowDeserializationSchema

def read_from_kafka(env):
    """
    message info
    """
    type_info = Types.ROW([Types.STRING(),
                   Types.FLOAT(),
                   Types.FLOAT(),
                   Types.FLOAT(),
                   Types.FLOAT(),
                   Types.FLOAT(),
                   Types.FLOAT(),
                   Types.INT(),
                   Types.BIG_INT(),
                   Types.BIG_INT(),
                   Types.BIG_INT()])
    
    """
    consume
    """
    deserialization_schema = JsonRowDeserializationSchema.Builder().type_info(type_info).build()
    kafka_consumer = FlinkKafkaConsumer(
        topics='crypto.candles_minute',
        deserialization_schema=deserialization_schema,
        properties={'bootstrap.servers': "192.168.10.4:9081,192.168.10.4:9082,192.168.10.4:9083", 'group.id': 'flink-processing'}
    )
    kafka_consumer.set_start_from_latest()
    
    """
    process messages from kafka
    """
    # WRITE PROCESSING HERE
    
    
    """
    produce
    """
    serialization_schema = JsonRowSerializationSchema.Builder() \
        .with_type_info(type_info) \
        .build()
    kafka_producer = FlinkKafkaProducer(
        topic='flink_processed',
        serialization_schema=serialization_schema,
        producer_config={'bootstrap.servers': "192.168.10.4:9081,192.168.10.4:9082,192.168.10.4:9083"}
    )
    
    
    """
    execute
    """
    env.add_source(kafka_consumer).add_sink(kafka_producer)
    env.execute()


if __name__ == '__main__':
    logging.basicConfig(stream=sys.stdout, level=logging.INFO, format="%(message)s")

    env = StreamExecutionEnvironment.get_execution_environment()
    env.add_jars("file:///home/pyuser/flink/flink-1.18.1/opt/flink-sql-connector-kafka-3.1.0-1.18.jar")
    
    print("start reading data from kafka")
    read_from_kafka(env)