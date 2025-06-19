# 고객 정보를 저장하는 SQLAlchemy 모델입니다.
# app/models/customer.py
from sqlalchemy import String, Integer
from sqlalchemy.orm import Mapped, mapped_column
from app.database import Base

class Customer(Base):
    __tablename__ = "Customer"
    cno:        Mapped[int]    = mapped_column("cno", Integer, primary_key=True)
    name:       Mapped[str]    = mapped_column(String(50))
    passwd:     Mapped[str]    = mapped_column(String(128))   # 해시 저장
    email:      Mapped[str]    = mapped_column(String(100))
    passportNumber: Mapped[str] = mapped_column(String(20))
