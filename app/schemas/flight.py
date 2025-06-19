from datetime import datetime
from pydantic import BaseModel
from typing import List

class SeatOut(BaseModel):
    seatClass: str
    price: float
    no_of_seats: int

    class Config:
        orm_mode = True

class FlightOut(BaseModel):
    airline: str
    flightNo: str
    departureDateTime: datetime
    departureAirport: str
    arrivalDateTime: datetime
    arrivalAirport: str
    seats: List[SeatOut] = []

    class Config:
        orm_mode = True
