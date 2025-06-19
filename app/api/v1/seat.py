# 항공기 좌석 관리 API 라우터입니다.
from fastapi import APIRouter, Path, Depends
from sqlalchemy.orm import Session

from app.database import get_db
from app.crud import seat as crud_seat
from app.schemas.flight import SeatOut

router = APIRouter(prefix="/admin/flights", tags=["seats"])

@router.get("/{flight_no}/{dep_dt}/seats", response_model=list[SeatOut])
def list_seats(
    flight_no: str = Path(...),
    dep_dt: str = Path(...),
    db: Session = Depends(get_db),
):
    """List seat classes for a flight."""
    return crud_seat.list_by_flight(db, flight_no, dep_dt)

@router.delete("/{flight_no}/{dep_dt}/seats/{seat_class}", status_code=204)
def delete_seat(
    flight_no: str = Path(...),
    dep_dt: str = Path(...),
    seat_class: str = Path(...),
    db: Session = Depends(get_db),
):
    """Remove a seat class from a flight."""
    crud_seat.delete(db, flight_no, dep_dt, seat_class)

