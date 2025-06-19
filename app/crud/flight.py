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
