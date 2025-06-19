from datetime import datetime
from sqlalchemy.orm import Session
from app.models.reservation import Reserve
from app.schemas.reservation import ReservationCreate


def create(db: Session, obj_in: ReservationCreate) -> Reserve:
    db_obj = Reserve(**obj_in.dict(), reserveDateTime=obj_in.departureDateTime)
    db.add(db_obj)
    db.commit()
    db.refresh(db_obj)
    return db_obj


def get(
    db: Session,
    flight_no: str,
    dep_dt: str,
    seat_class: str,
    cno: int,
) -> Reserve | None:
    dep_dt_parsed = datetime.fromisoformat(dep_dt)
    return db.get(
        Reserve,
        {
            "flightNo": flight_no,
            "departureDateTime": dep_dt_parsed,
            "seatClass": seat_class,
            "cno": cno,
        },
    )
