# 데이터베이스 연결과 세션을 관리합니다.
# app/database.py
from sqlalchemy import create_engine
from sqlalchemy.orm import DeclarativeBase, sessionmaker
from app.config import get_settings

settings = get_settings()
DB_URI = (
    f"oracle+oracledb://{settings.oracle_user}:{settings.oracle_password}"
    f"@{settings.oracle_dsn}?encoding=UTF-8&nencoding=UTF-8"
)

engine = create_engine(DB_URI, pool_recycle=3600, echo=False)
SessionLocal = sessionmaker(bind=engine, autoflush=False, expire_on_commit=False)

class Base(DeclarativeBase):
    pass

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
