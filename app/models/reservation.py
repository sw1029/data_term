# 예약 및 취소 정보를 위한 모델을 정의합니다.
from __future__ import annotations

from datetime import datetime
from sqlalchemy import (
    String,
    DateTime,
    Integer,
    Numeric,
    ForeignKey,
    ForeignKeyConstraint,
    UniqueConstraint,
)
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.database import Base

class Reserve(Base):
    __tablename__ = "Reserve"

    reservationId: Mapped[int] = mapped_column(Integer, primary_key=True, autoincrement=True)
    flightNo: Mapped[str] = mapped_column(String(20))
    departureDateTime: Mapped[datetime] = mapped_column(DateTime)
    seatClass: Mapped[str] = mapped_column(String(20))
    cno: Mapped[int] = mapped_column(ForeignKey("Customer.cno"))
    payment: Mapped[float] = mapped_column(Numeric)
    reserveDateTime: Mapped[datetime] = mapped_column(DateTime)

    __table_args__ = (
        ForeignKeyConstraint(
            ["flightNo", "departureDateTime", "seatClass"],
            ["Seats.flightNo", "Seats.departureDateTime", "Seats.seatClass"],
        ),
        UniqueConstraint("flightNo", "departureDateTime", "seatClass", "cno"),
    )

    customer: Mapped["Customer"] = relationship("Customer")

class Cancel(Base):
    __tablename__ = "Cancel"

    flightNo: Mapped[str] = mapped_column(String(20), primary_key=True)
    departureDateTime: Mapped[datetime] = mapped_column(DateTime, primary_key=True)
    seatClass: Mapped[str] = mapped_column(String(20), primary_key=True)
    cno: Mapped[int] = mapped_column(ForeignKey("Customer.cno"), primary_key=True)
    refund: Mapped[float] = mapped_column(Numeric)
    cancelDateTime: Mapped[datetime] = mapped_column(DateTime)

    __table_args__ = (
        ForeignKeyConstraint(
            ["flightNo", "departureDateTime", "seatClass"],
            ["Seats.flightNo", "Seats.departureDateTime", "Seats.seatClass"],
        ),
    )

    customer: Mapped["Customer"] = relationship("Customer")
