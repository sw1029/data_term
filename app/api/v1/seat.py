from fastapi import APIRouter, Path

router = APIRouter(prefix="/admin/flights", tags=["seats"])

@router.get("/{flight_id}/seats")
def list_seats(flight_id: int = Path(...)):
    """Return demo seat list for the given flight."""
    return [
        {"id": 1, "class": "Economy", "price": 120000, "total": 100},
        {"id": 2, "class": "Business", "price": 500000, "total": 20},
    ]

@router.delete("/{flight_id}/seats/{seat_id}", status_code=204)
def delete_seat(
    flight_id: int = Path(...),
    seat_id: int = Path(...),
):
    """Demo deletion endpoint."""
    return

