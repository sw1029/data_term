from fastapi import APIRouter, Path, status, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import get_db
from app.core.auth_deps import get_current_user
from app.crud import reservation as crud_reservation
from app.models.customer import Customer
from app.schemas.reservation import ReservationCreate, ReservationOut

router = APIRouter(prefix="/reservations", tags=["reservations"])


@router.post("/", response_model=ReservationOut, status_code=status.HTTP_201_CREATED)
def create_reservation(payload: ReservationCreate, db: Session = Depends(get_db)):
    """Create a new reservation."""
    return crud_reservation.create(db, payload)


@router.get("/{reservation_id}", response_model=ReservationOut)
def read_reservation(
    reservation_id: int = Path(...),
    db: Session = Depends(get_db),
):
    """Fetch a reservation by id."""
    db_obj = crud_reservation.get(db, reservation_id)
    if not db_obj:
        raise HTTPException(status_code=404, detail="Reservation not found")
    return db_obj


@router.delete("/{reservation_id}", response_model=ReservationOut)
def delete_reservation(
    reservation_id: int,
    db: Session = Depends(get_db),
    current_user: Customer = Depends(get_current_user),
):
    """Cancel (delete) a reservation."""
    db_reservation = crud_reservation.get(db, reservation_id)
    if db_reservation is None:
        raise HTTPException(status_code=404, detail="Reservation not found")
    if db_reservation.cno != current_user.cno:
        raise HTTPException(status_code=403, detail="Not authorized to delete this reservation")

    deleted = crud_reservation.remove(db, reservation_id)
    return deleted

