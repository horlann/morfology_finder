import sqlite3
import json
import os

DB_FILE = '/Users/admin/Programming/flutter_projects/morfology_finder/db/morphology.db'  # Change this to your .db file
EXPORT_FOLDER = 'json_exports'

conn = sqlite3.connect(DB_FILE)
cursor = conn.cursor()

cursor.execute("SELECT name FROM sqlite_master WHERE type='table';")
tables = [row[0] for row in cursor.fetchall()]

print(f"📋 Tables found: {tables}")
os.makedirs(EXPORT_FOLDER, exist_ok=True)

for table_name in tables:
    if table_name.startswith('sqlite_'):  # skip system tables
        print(f"⚠️ Skipping system table: {table_name}")
        continue

    print(f"📦 Exporting table: {table_name}...")

    cursor.execute(f"SELECT * FROM {table_name}")
    rows = cursor.fetchall()

    if not rows:
        print(f"⚠️ Table '{table_name}' has no data.")
        continue

    col_names = [description[0] for description in cursor.description]
    data = [dict(zip(col_names, row)) for row in rows]

    output_file = f"{EXPORT_FOLDER}/{table_name}.json"
    with open(output_file, "w", encoding='utf-8') as f:
        json.dump(data, f, indent=2)

    print(f"✅ Wrote {len(data)} rows to {output_file}")

conn.close()

