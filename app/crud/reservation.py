from datetime import datetime
from sqlalchemy import select
from sqlalchemy.orm import Session

from app.models.reservation import Reserve, Cancel
from app.models.flight import Seats
from app.schemas.reservation import ReservationCreate


def create(db: Session, obj_in: ReservationCreate) -> Reserve:
    db_obj = Reserve(**obj_in.dict(), reserveDateTime=datetime.utcnow())
    db.add(db_obj)
    db.commit()
    db.refresh(db_obj)
    return db_obj


def create_with_seat_update(db: Session, *, reservation_in: ReservationCreate, cno: int) -> Reserve:
    """Create reservation and decrease remaining seats atomically."""
    seat = (
        db.query(Seats)
        .filter(
            Seats.flightNo == reservation_in.flight_no,
            Seats.departureDateTime == reservation_in.dep_dt,
            Seats.seatClass == reservation_in.seat_class,
        )
        .with_for_update()
        .first()
    )

    if not seat or seat.no_of_seats <= 0:
        raise ValueError("해당 좌석 등급의 예약이 마감되었습니다.")

    seat.no_of_seats -= 1

    db_obj = Reserve(
        flightNo=reservation_in.flight_no,
        departureDateTime=reservation_in.dep_dt,
        seatClass=reservation_in.seat_class,
        cno=cno,
        payment=seat.price,
        reserveDateTime=datetime.utcnow(),
    )

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


def cancel_and_move(db: Session, *, rno: int, cno: int) -> Cancel:
    """Move reservation to Cancel table and restore seat count."""
    reserve_to_cancel = (
        db.query(Reserve)
        .filter(Reserve.reservationId == rno, Reserve.cno == cno)
        .first()
    )

    if not reserve_to_cancel:
        raise ValueError("존재하지 않거나 취소 권한이 없는 예약입니다.")

    seat = (
        db.query(Seats)
        .filter(
            Seats.flightNo == reserve_to_cancel.flightNo,
            Seats.departureDateTime == reserve_to_cancel.departureDateTime,
            Seats.seatClass == reserve_to_cancel.seatClass,
        )
        .with_for_update()
        .first()
    )
    if seat:
        seat.no_of_seats += 1

    cancel_obj = Cancel(
        flightNo=reserve_to_cancel.flightNo,
        departureDateTime=reserve_to_cancel.departureDateTime,
        seatClass=reserve_to_cancel.seatClass,
        cno=reserve_to_cancel.cno,
        refund=reserve_to_cancel.payment,
        cancelDateTime=datetime.utcnow(),
    )
    db.add(cancel_obj)
    db.delete(reserve_to_cancel)
    db.commit()
    db.refresh(cancel_obj)
    return cancel_obj
