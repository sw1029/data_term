from datetime import datetime
from pydantic import BaseModel

class ReservationCreate(BaseModel):
    flightNo: str
    departureDateTime: datetime
    seatClass: str
    cno: int
    payment: float

class ReservationOut(BaseModel):
    flightNo: str
    departureDateTime: datetime
    seatClass: str
    cno: int
    payment: float
    reserveDateTime: datetime

    class Config:
        orm_mode = True
