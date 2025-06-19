# app/api/v1/admin_panel.py
from fastapi import APIRouter, Depends, Path, Query
from sqlalchemy.orm import Session

from app.api.deps import get_db
from app.core.auth_deps import admin_required
from app.crud import flight as crud_flight, seat as crud_seat, customer as crud_customer
from app.schemas.flight import FlightOut
from app.schemas.customer import CustomerOut

router = APIRouter(prefix="/admin/panel", tags=["admin-panel"], dependencies=[Depends(admin_required)])

# 예시 1: 특정 승객 강제 삭제
@router.delete("/customers/{cno}", status_code=204)
def delete_customer(cno: int = Path(..., ge=1), db: Session = Depends(get_db)):
    db_obj = crud_customer.get(db, cno)
    if db_obj:
        db.delete(db_obj); db.commit()

# 예시 2: 항공편 목록 조회(필터링)
@router.get("/flights", response_model=list[FlightOut])
def list_flights(
    departure_airport: str | None = Query(None),
    db: Session = Depends(get_db),
):
    return crud_flight.list(db, departure_airport=departure_airport)

# 예시 3: 좌석 가격 일괄 조정
@router.patch("/flights/{flight_no}/{dep_dt}/seats/price-bulk", status_code=200)
def bulk_update_seat_price(
    flight_no: str,
    dep_dt: str,
    percentage: float = Query(..., description="+10 → 10% 인상, -5 → 5% 인하"),
    db: Session = Depends(get_db),
):
    updated = crud_seat.adjust_price(db, flight_no, dep_dt, percentage)
    return {"updated_rows": updated}
