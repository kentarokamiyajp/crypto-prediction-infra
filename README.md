# Infra for Crypto Price Prediction
![image](https://github.com/kamikennn/crypto-prediction-devops/assets/45506894/01582408-1179-4f7a-b975-213ee8e7a474)
## System Overview
- https://miro.com/app/board/uXjVMgqA6r8=/?share_link_id=394438367657
## Related Repositories
- ETL
  - https://github.com/kamikennn/crypto_prediction_etl
- ML/DL
  - https://github.com/kamikennn/crypto_prediction_ml_dl
## Source of Crypto Price and Other Useful Data
- Poloniex (https://api-docs.poloniex.com/spot)
  - Crypto price data
- Yahoo Finance (https://finance.yahoo.com/)
  - Forex price data
  - Stack index data
  - Others
## Realtime Data Streaming
- Data from Poloniex via WebSocket
  - Order book
  - Market trade
  - Crypto price for every minute
- Event streaming platform
  - Kafka
- Streaming Data Processing Tools
  - Kafka Consumer
  - Flink
  - Spark Streaming
## Source Database
- Cassandra
- MongoDB
## Data Warehouse System
- Main DB
  - Hive built on HDFS
- ETL tools
  - Spark
  - Trino
  - DBT(?)
## Data Analyzation
- Druid for real-time analysis
- Trino for ad-hoc analysis
## Job Scheduling Tool
- Airflow
