# 사용자 프로필 및 예약 조회 API를 제공합니다.
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from app.core.auth_deps import get_current_user
from app.database import get_db
from app.crud import reservation as crud_reservation
from app.models.customer import Customer
from app.schemas.reservation import ReservationOut

router = APIRouter(prefix="/profile", tags=["user-profile"])

@router.get("/me")
def read_profile(current_user: Customer = Depends(get_current_user)):
    """Return current user info."""
    return {
        "cno": current_user.cno,
        "name": current_user.name,
        "email": current_user.email,
    }


@router.get("/me/reservations", response_model=list[ReservationOut])
def read_my_reservations(
    current_user: Customer = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Return reservations for the logged in user."""
    return crud_reservation.get_by_customer(db, cno=current_user.cno)

