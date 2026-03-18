import os
import time
import psycopg2
from flask import Flask, jsonify

app = Flask(__name__)

DB_HOST = os.getenv("DB_HOST", "postgres")
DB_NAME = os.getenv("DB_NAME", "myapp")
DB_USER = os.getenv("DB_USER", "myappuser")
DB_PASSWORD = os.getenv("DB_PASSWORD", "mypassword")
DB_PORT = int(os.getenv("DB_PORT", "5432"))


def get_db_connection():
    return psycopg2.connect(
        host=DB_HOST,
        database=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        port=DB_PORT,
    )


def init_db():
    retries = 10
    delay = 3

    for attempt in range(1, retries + 1):
        try:
            conn = get_db_connection()
            cur = conn.cursor()
            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS visits (
                    id SERIAL PRIMARY KEY,
                    visited_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                );
                """
            )
            conn.commit()
            cur.close()
            conn.close()
            print("Database initialized successfully")
            return
        except Exception as e:
            print(f"Database init failed on attempt {attempt}/{retries}: {e}")
            time.sleep(delay)

    raise Exception("Could not initialize database after multiple attempts")


@app.route("/")
def home():
    return jsonify({
        "message": "DevOps Project 4 - Dockerized Platform",
        "status": "running"
    })


@app.route("/health")
def health():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT 1;")
        cur.fetchone()
        cur.close()
        conn.close()

        return jsonify({
            "status": "healthy",
            "app": "ok",
            "database": "ok"
        }), 200
    except Exception as e:
        return jsonify({
            "status": "unhealthy",
            "app": "ok",
            "database": "error",
            "details": str(e)
        }), 500


@app.route("/visit")
def visit():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("INSERT INTO visits DEFAULT VALUES RETURNING id;")
        visit_id = cur.fetchone()[0]
        conn.commit()
        cur.close()
        conn.close()

        return jsonify({
            "message": "Visit recorded",
            "visit_id": visit_id
        }), 201
    except Exception as e:
        return jsonify({
            "error": str(e)
        }), 500


if __name__ == "__main__":
    init_db()
    app.run(host="0.0.0.0", port=5000)
