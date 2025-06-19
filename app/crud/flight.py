# 항공편 모델에 대한 CRUD 로직을 제공합니다.
from datetime import date, datetime
from sqlalchemy import select, func
from sqlalchemy.orm import Session, selectinload

from app.models.flight import Airplain


def list(db: Session, departure_airport: str | None = None):
    stmt = select(Airplain)
    if departure_airport:
        stmt = stmt.where(Airplain.departureAirport == departure_airport)
    return db.scalars(stmt).all()


def search(db: Session, departure: str, arrival: str, dep_date: date):
    stmt = (
        select(Airplain)
        .where(
            Airplain.departureAirport == departure,
            Airplain.arrivalAirport == arrival,
            func.trunc(Airplain.departureDateTime) == dep_date,
        )
        .options(selectinload(Airplain.seats))
    )
    return db.scalars(stmt).all()


def remove_by_flight_no_and_dt(db: Session, *, flight_no: str, dep_dt: datetime):
    db_obj = db.get(Airplain, {"flightNo": flight_no, "departureDateTime": dep_dt})
    if not db_obj:
        return None
    db.delete(db_obj)
    db.commit()
    return db_obj
