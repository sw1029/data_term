from fastapi import APIRouter, Query

router = APIRouter(prefix="/flights", tags=["flights"])

@router.get("/search")
def search_flights(
    origin: str = Query(..., alias="from"),
    dest: str = Query(..., alias="to"),
    depDate: str = Query(...),
    retDate: str | None = Query(None),
):
    """Demo search endpoint returning static data."""
    return [
        {
            "flightId": 1,
            "airline": "Sample Air",
            "flightNo": "SA100",
            "departureTime": f"{depDate}T08:00:00",
            "arrivalTime": f"{depDate}T10:30:00",
            "duration": "2h30m",
            "seatClass": "Economy",
            "price": 120000,
            "remaining": 20,
        }
    ]

