# 항공편과 좌석 관련 스키마를 정의합니다.
from datetime import datetime
from pydantic import BaseModel
from typing import List

class SeatOut(BaseModel):
    seatClass: str
    price: float
    no_of_seats: int

    class Config:
        from_attributes = True

class FlightOut(BaseModel):
    airline: str
    flightNo: str
    departureDateTime: datetime
    departureAirport: str
    arrivalDateTime: datetime
    arrivalAirport: str
    seats: List[SeatOut] = []

    class Config:
        from_attributes = True
