from pyspark.sql import SparkSession
from pyspark.sql.functions import col, to_timestamp

# -----------------------------------
# Spark session with Hive support
# -----------------------------------
spark = SparkSession.builder \
    .appName("Ecommerce ETL Pipeline") \
    .enableHiveSupport() \
    .getOrCreate()

# -----------------------------------
# Load raw data from HDFS
# -----------------------------------
customers = spark.read.csv(
    "hdfs://localhost:9000/ecommerce/raw/olist_customers_dataset.csv",
    header=True,
    inferSchema=True
)

orders = spark.read.csv(
    "hdfs://localhost:9000/ecommerce/raw/olist_orders_dataset.csv",
    header=True,
    inferSchema=True
)

payments = spark.read.csv(
    "hdfs://localhost:9000/ecommerce/raw/olist_order_payments_dataset.csv",
    header=True,
    inferSchema=True
)

items = spark.read.csv(
    "hdfs://localhost:9000/ecommerce/raw/olist_order_items_dataset.csv",
    header=True,
    inferSchema=True
)

products = spark.read.csv(
    "hdfs://localhost:9000/ecommerce/raw/olist_products_dataset.csv",
    header=True,
    inferSchema=True
)

# -----------------------------------
# Data cleaning
# -----------------------------------
orders = orders.withColumn(
    "order_purchase_timestamp",
    to_timestamp("order_purchase_timestamp")
)

# -----------------------------------
# Join datasets (business model)
# -----------------------------------
sales = orders.join(customers, "customer_id") \
              .join(payments, "order_id") \
              .join(items, "order_id") \
              .join(products, "product_id")

# -----------------------------------
# Feature engineering
# -----------------------------------
sales = sales.select(
    "order_id",
    "customer_unique_id",
    "payment_value",
    "product_category_name",
    "order_purchase_timestamp"
)

# -----------------------------------
# Save processed data (Parquet)
# -----------------------------------
sales.write.mode("overwrite").parquet(
    "hdfs://localhost:9000/ecommerce/processed/sales"
)

print("ETL COMPLETED SUCCESSFULLY")

spark.stop()
