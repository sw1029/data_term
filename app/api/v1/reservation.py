from fastapi import APIRouter, Path, status

router = APIRouter(prefix="/reservations", tags=["reservations"])

_demo_reservation = {
    "code": "ABC123456789",
    "createdAt": "2025-01-01T12:00:00",
    "customerName": "Demo User",
    "cno": 1,
    "price": 120000,
    "status": "CONFIRMED",
    "seatClass": "Economy",
    "seatPrice": 120000,
    "flight": {
        "flightNo": "SA100",
        "airline": "Sample Air",
        "from": "ICN",
        "to": "JFK",
        "departureTime": "2025-01-10T08:00:00",
        "arrivalTime": "2025-01-10T10:30:00",
    },
}

@router.get("/{code}")
def read_reservation(code: str = Path(...)):
    """Return a demo reservation."""
    return _demo_reservation | {"code": code}

@router.delete("/{code}", status_code=status.HTTP_204_NO_CONTENT)
def cancel_reservation(code: str = Path(...)):
    """Pretend to cancel a reservation."""
    return

