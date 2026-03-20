 🛒 Distributed E-Commerce Data Pipeline
Hadoop · Apache Spark · Apache Hive · Python · SQL



A production-style \*\*end-to-end ETL pipeline\*\* built on the real-world \*\*Olist Brazilian E-Commerce dataset\*\* (Kaggle). Raw CSV data across 5 relational tables is ingested into HDFS, joined and transformed using Apache Spark (PySpark), stored in optimized Parquet format, and analysed using 8 business-intelligence queries in Apache Hive.


📐 Architecture



```

Olist Dataset (5 CSV files)
      │

      ▼
 HDFS — Raw Layer

hdfs://localhost:9000/ecommerce/raw/

       │

       ▼

Apache Spark (PySpark)

 ├── Load 5 CSVs

 ├── Clean timestamps

 ├── Join: orders ⟶ customers ⟶ payments ⟶ items ⟶ products

 └── Feature selection
       │

       ▼
 Parquet — Processed Layer

 hdfs://localhost:9000/ecommerce/processed/sales

       │

       ▼

 Apache Hive — Analytics Layer

 └── 8 Business Intelligence Queries

       │

       ▼

Output CSVs → /home/kaviya/hive\_outputs/



\---



🗂️ Dataset



Source: \[Olist Brazilian E-Commerce Dataset — Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)



| File | Description |



| `olist\_customers\_dataset.csv` | Customer profiles and locations |

| `olist\_orders\_dataset.csv` | Order status and timestamps |

| `olist\_order\_payments\_dataset.csv` | Payment values and methods |

| `olist\_order\_items\_dataset.csv` | Items per order |

| `olist\_products\_dataset.csv` | Product categories |







⚙️ Tech Stack



| Tool | Purpose |


| HDFS | Distributed storage — raw and processed data |

| Apache Spark (PySpark) | Multi-table join, cleaning, transformation |

| Apache Hive | SQL-based analytical queries |

| Parquet | Columnar storage for optimized querying |

| Python 3 | Pipeline scripting |

| SQL | 8 business intelligence queries |






Hive Analytics (`hive\_queries.sql`)



8 business intelligence queries run against the Parquet-backed Hive table:



| Query | Output Folder |



| 1 | Total Revenue Generated | `hive\_outputs/total\_revenue` |

| 2 | Total Number of Orders | `hive\_outputs/total\_orders` |

| 3 | Average Order Value | `hive\_outputs/average\_order\_value` |

| 4 | Top 10 Highest Paying Customers | `hive\_outputs/top\_customers` |

| 5 | Min and Max Payment Values | `hive\_outputs/min\_max\_payment` |

| 6 | Customers with More than 5 Orders | `hive\_outputs/frequent\_customers` |

| 7 | Revenue by Payment Range (Low/Medium/High) | `hive\_outputs/payment\_range\_distribution` |

| 8 | Top 5 Orders by Payment Value | `hive\_outputs/top\_orders` |



✅ Verified Output



All 8 query outputs successfully generated and saved to local directories .


output/

├── average\_order\_value/

├── frequent\_customers/

├── min\_max\_payment/

├── payment\_range\_distribution/

├── sales/                        ← Parquet processed data

├── top\_customers/

├── top\_orders/

├── total\_orders/

└── total\_revenue/


🛠️ How to Run

```bash

 1. Clone the repo

git clone https://github.com/KaviyaSri310/hadoop-spark-ecommerce-pipeline

cd hadoop-spark-ecommerce-pipeline


 2. Start Hadoop \& Hive services

start-dfs.sh

start-yarn.sh


 3. Upload raw data to HDFS

hdfs dfs -mkdir -p /ecommerce/raw

hdfs dfs -put data/\*.csv /ecommerce/raw/


 4. Run the Spark ETL job

spark-submit etl\_pipeline.py


 5. Run Hive analytics

hive -f hive\_queries.sql



👩‍💻 Author

Kaviya Sri G

B.Tech AI & Data Science | Kangeyam Institute of Technology

📧 kaviyaganesh310@gmail.com

🔗 LinkedIn : (https://linkedin.com/in/kaviya-sri-g-309a4a344) 

