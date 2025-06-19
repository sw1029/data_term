# 관리자 전용 기능을 제공하는 API 라우터입니다.
# app/api/v1/admin_panel.py
from fastapi import APIRouter, Depends, Path, Query, HTTPException, Response, status
from sqlalchemy.orm import Session
from datetime import datetime

from app.database import get_db
from app.core.auth_deps import admin_required
from app.crud import flight as crud_flight, seat as crud_seat, customer as crud_customer
from app.schemas.flight import FlightOut
from app.schemas.customer import CustomerOut

router = APIRouter(prefix="/admin", tags=["admin-panel"], dependencies=[Depends(admin_required)])

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


@router.delete(
    "/flights/{flight_no}/{dep_dt}",
    status_code=status.HTTP_204_NO_CONTENT,
)
def delete_flight(
    flight_no: str,
    dep_dt: str,
    db: Session = Depends(get_db),
):
    """Delete a flight identified by flight number and departure datetime."""
    dep_dt_parsed = datetime.fromisoformat(dep_dt)
    deleted = crud_flight.remove_by_flight_no_and_dt(
        db, flight_no=flight_no, dep_dt=dep_dt_parsed
    )
    if not deleted:
        raise HTTPException(status_code=404, detail="해당 항공편을 찾을 수 없습니다.")
    return Response(status_code=status.HTTP_204_NO_CONTENT)
