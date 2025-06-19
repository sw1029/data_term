from datetime import datetime
from sqlalchemy import update, select
from sqlalchemy.orm import Session

from app.models.flight import Seats


def adjust_price(db: Session, flight_no: str, dep_dt: str, percentage: float) -> int:
    dep_dt_parsed = datetime.fromisoformat(dep_dt)
    stmt = (
        update(Seats)
        .where(Seats.flightNo == flight_no, Seats.departureDateTime == dep_dt_parsed)
        .values(price=Seats.price * (1 + percentage / 100))
    )
    result = db.execute(stmt)
    db.commit()
    return result.rowcount


def list_by_flight(db: Session, flight_no: str, dep_dt: str) -> list[Seats]:
    dep_dt_parsed = datetime.fromisoformat(dep_dt)
    stmt = select(Seats).where(
        Seats.flightNo == flight_no,
        Seats.departureDateTime == dep_dt_parsed,
    )
    return db.scalars(stmt).all()


def delete(db: Session, flight_no: str, dep_dt: str, seat_class: str) -> int:
    dep_dt_parsed = datetime.fromisoformat(dep_dt)
    obj = db.get(Seats, {"flightNo": flight_no, "departureDateTime": dep_dt_parsed, "seatClass": seat_class})
    if obj:
        db.delete(obj)
        db.commit()
        return 1
    return 0
