# 예약 관련 API 엔드포인트를 정의합니다.
from fastapi import APIRouter, Path, status, Depends, HTTPException
from sqlalchemy.orm import Session

from app.database import get_db
from app.core.auth_deps import get_current_user
from app.crud import reservation as crud_reservation
from app.models.customer import Customer
from app.schemas.reservation import ReservationCreate, ReservationOut

router = APIRouter(prefix="/reservations", tags=["reservations"])


@router.post("/", response_model=ReservationOut, status_code=status.HTTP_201_CREATED)
def create_reservation(
    payload: ReservationCreate,
    db: Session = Depends(get_db),
    current_user: Customer = Depends(get_current_user),
):
    """Create a new reservation for the authenticated user."""
    try:
        return crud_reservation.create_with_seat_update(
            db=db, reservation_in=payload, cno=current_user.cno
        )
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


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


@router.delete("/{reservation_id}", status_code=204)
def delete_reservation(
    reservation_id: int,
    db: Session = Depends(get_db),
    current_user: Customer = Depends(get_current_user),
):
    """Cancel a reservation and move it to the Cancel table."""
    try:
        crud_reservation.cancel_and_move(
            db=db, rno=reservation_id, cno=current_user.cno
        )
    except ValueError as e:
        raise HTTPException(status_code=404, detail=str(e))

    return

