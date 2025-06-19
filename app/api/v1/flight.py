from fastapi import APIRouter, Query, Depends
from sqlalchemy.orm import Session
from datetime import datetime
from typing import List, Dict, Any

from app.database import get_db
from app.crud import flight as crud_flight

router = APIRouter(prefix="/flights", tags=["flights"])

@router.get("/search", response_model=List[Dict[str, Any]])
def search_flights(
    origin: str = Query(..., alias="from"),
    dest: str = Query(..., alias="to"),
    depDate: str = Query(...),
    db: Session = Depends(get_db),
):
    """Search flights from the database and flatten seat data for the front-end."""
    dep_date = datetime.fromisoformat(depDate).date()
    flights = crud_flight.search(db, origin, dest, dep_date)

    flattened_results: List[Dict[str, Any]] = []
    for flight in flights:
        for seat in flight.seats:
            flattened_results.append(
                {
                    "airline": flight.airline,
                    "flightNo": flight.flightNo,
                    "departureAirport": flight.departureAirport,
                    "arrivalAirport": flight.arrivalAirport,
                    "departureDateTime": flight.departureDateTime.isoformat(),
                    "arrivalDateTime": flight.arrivalDateTime.isoformat(),
                    "seatClass": seat.seatClass,
                    "price": seat.price,
                    "remaining": seat.no_of_seats,
                }
            )

    return flattened_results

