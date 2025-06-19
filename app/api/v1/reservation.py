from fastapi import APIRouter, Path, status, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import get_db
from app.crud import reservation as crud_reservation
from app.schemas.reservation import ReservationCreate, ReservationOut

router = APIRouter(prefix="/reservations", tags=["reservations"])


@router.post("/", response_model=ReservationOut, status_code=status.HTTP_201_CREATED)
def create_reservation(payload: ReservationCreate, db: Session = Depends(get_db)):
    """Create a new reservation."""
    return crud_reservation.create(db, payload)


@router.get("/{flight_no}/{dep_dt}/{seat_class}/{cno}", response_model=ReservationOut)
def read_reservation(
    flight_no: str = Path(...),
    dep_dt: str = Path(...),
    seat_class: str = Path(...),
    cno: int = Path(...),
    db: Session = Depends(get_db),
):
    """Fetch a reservation by composite key."""
    db_obj = crud_reservation.get(db, flight_no, dep_dt, seat_class, cno)
    if not db_obj:
        raise HTTPException(status_code=404, detail="Reservation not found")
    return db_obj


@router.delete("/{flight_no}/{dep_dt}/{seat_class}/{cno}", status_code=status.HTTP_204_NO_CONTENT)
def cancel_reservation(
    flight_no: str = Path(...),
    dep_dt: str = Path(...),
    seat_class: str = Path(...),
    cno: int = Path(...),
    db: Session = Depends(get_db),
):
    """Cancel (delete) a reservation."""
    obj = crud_reservation.get(db, flight_no, dep_dt, seat_class, cno)
    if obj:
        db.delete(obj)
        db.commit()
    return

