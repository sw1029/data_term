# 예약 생성 및 조회에 사용되는 스키마입니다.
from datetime import datetime
from pydantic import BaseModel

class ReservationCreate(BaseModel):
    flight_no: str
    dep_dt: datetime
    seat_class: str

class ReservationOut(BaseModel):
    reservationId: int
    flightNo: str
    departureDateTime: datetime
    seatClass: str
    cno: int
    payment: float
    reserveDateTime: datetime

    class Config:
        from_attributes = True
