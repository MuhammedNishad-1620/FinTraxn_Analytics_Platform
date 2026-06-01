import os
import pandas as pd
import snowflake.connector
from snowflake.connector.pandas_tools import write_pandas
from dotenv import load_dotenv

load_dotenv()

conn = snowflake.connector.connect(
    account = os.getenv('SNOWFLAKE_ACCOUNT'),
    user = os.getenv('SNOWFLAKE_USER'),
    password = os.getenv('SNOWFLAKE_PASSWORD'),
    database = os.getenv('SNOWFLAKE_DATABASE'),
    schema = os.getenv('SNOWFLAKE_SCHEMA'),
    warehouse = os.getenv('SNOWFLAKE_WAREHOUSE'),
    role = os.getenv('SNOWFLAKE_ROLE')
)

tables = {
    'CUSTOMER_PROFILES' : 'data/customer_profiles.csv',
    'ACCOUNT_TRANSACTIONS' : 'data/account_transactions.csv',
    'BANK_ACCOUNTS' : 'data/bank_accounts.csv'
    }
for table_name, path in tables.items():
    print(f"Loading {table_name} from {path}...")
    df = pd.read_csv(path)
    df.columns=[c.upper() for c in df.columns]
    success, nchunks, nrows, _ = write_pandas(conn, df, table_name, auto_create_table=True)
    print(f"Successfully loaded {nrows} rows into {table_name}")

conn.close()

print("All tables loaded successfully")