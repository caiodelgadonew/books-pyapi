import os
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from .logger import _setup_logging

log = _setup_logging()

DB_TYPE = os.getenv("DB_TYPE", "sqlite")
DB_PATH = os.getenv("DB_PATH", "./database.db")
DB_HOST = os.getenv("DB_HOST", "127.0.0.1")
DB_PORT = os.getenv("DB_PORT", "3306")
DB_NAME = os.getenv("DB_NAME", "books")
DB_USER = os.getenv("DB_USER", "user")
DB_PASS = os.getenv("DB_PASS", "password")

if DB_TYPE == "mysql":
    log.info("Using MYSQL as Database")
    DATABASE_URL = f"mysql+mysqldb://{DB_USER}:{DB_PASS}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
if DB_TYPE == "sqlite":
    log.info("Using SQLITE as Database")
    DATABASE_URL = f"sqlite:///{DB_PATH}"
else:
    log.error(
        f"Database {DB_TYPE} is not supported, please set the env DB_TYPE to 'sqlite' or 'mysql'"
    )
    exit()


engine = create_engine(DATABASE_URL, connect_args={"check_same_thread": False})

SessionLocal = sessionmaker(bind=engine, autocommit=False, autoflush=False)

Base = declarative_base()


def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
