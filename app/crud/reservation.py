from datetime import datetime
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.models.reservation import Reserve
from app.schemas.reservation import ReservationCreate


def create(db: Session, obj_in: ReservationCreate) -> Reserve:
    db_obj = Reserve(**obj_in.dict(), reserveDateTime=obj_in.departureDateTime)
    db.add(db_obj)
    db.commit()
    db.refresh(db_obj)
    return db_obj


def get(db: Session, reservation_id: int) -> Reserve | None:
    return db.get(Reserve, reservation_id)


def get_by_customer(db: Session, cno: int) -> list[Reserve]:
    return db.scalars(select(Reserve).where(Reserve.cno == cno)).all()


def remove(db: Session, reservation_id: int) -> Reserve | None:
    db_obj = db.get(Reserve, reservation_id)
    if db_obj:
        db.delete(db_obj)
        db.commit()
    return db_obj
