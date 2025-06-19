# 관리자 테이블에 매핑되는 SQLAlchemy 모델입니다.
# app/models/admin.py
from sqlalchemy import String, Integer, Boolean
from sqlalchemy.orm import Mapped, mapped_column
from app.database import Base

class Admin(Base):
    __tablename__ = "Admin"
    id:        Mapped[int]  = mapped_column(Integer, primary_key=True, autoincrement=True)
    username:  Mapped[str]  = mapped_column(String(30), unique=True, index=True)
    passwd:    Mapped[str]  = mapped_column(String(128))
    is_super:  Mapped[bool] = mapped_column(Boolean, default=False)
