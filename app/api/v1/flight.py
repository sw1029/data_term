from fastapi import APIRouter, Query, Depends
from sqlalchemy.orm import Session
from datetime import datetime

from app.database import get_db
from app.crud import flight as crud_flight
from app.schemas.flight import FlightOut

router = APIRouter(prefix="/flights", tags=["flights"])

@router.get("/search", response_model=list[FlightOut])
def search_flights(
    origin: str = Query(..., alias="from"),
    dest: str = Query(..., alias="to"),
    depDate: str = Query(...),
    db: Session = Depends(get_db),
):
    """Search flights from the database."""
    dep_date = datetime.fromisoformat(depDate).date()
    return crud_flight.search(db, origin, dest, dep_date)

