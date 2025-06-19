# 항공편과 좌석 정보를 나타내는 모델 정의입니다.
from __future__ import annotations

from datetime import datetime
from sqlalchemy import String, DateTime, Integer, Numeric, ForeignKeyConstraint
from sqlalchemy.orm import Mapped, mapped_column, relationship
from app.database import Base

class Airplain(Base):
    __tablename__ = "Airplain"

    flightNo: Mapped[str] = mapped_column(String(20), primary_key=True)
    departureDateTime: Mapped[datetime] = mapped_column(DateTime, primary_key=True)
    airline: Mapped[str] = mapped_column(String(50))
    departureAirport: Mapped[str] = mapped_column(String(50))
    arrivalDateTime: Mapped[datetime] = mapped_column(DateTime)
    arrivalAirport: Mapped[str] = mapped_column(String(50))

    seats: Mapped[list["Seats"]] = relationship("Seats", back_populates="airplain")

class Seats(Base):
    __tablename__ = "Seats"

    flightNo: Mapped[str] = mapped_column(String(20), primary_key=True)
    departureDateTime: Mapped[datetime] = mapped_column(DateTime, primary_key=True)
    seatClass: Mapped[str] = mapped_column(String(20), primary_key=True)
    price: Mapped[float] = mapped_column(Numeric)
    no_of_seats: Mapped[int] = mapped_column(Integer)

    __table_args__ = (
        ForeignKeyConstraint([
            "flightNo",
            "departureDateTime",
        ], [
            "Airplain.flightNo",
            "Airplain.departureDateTime",
        ]),
    )

    airplain: Mapped[Airplain] = relationship("Airplain", back_populates="seats")
