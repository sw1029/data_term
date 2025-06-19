from fastapi import APIRouter, Depends
from app.core.auth_deps import get_current_user
from app.models.customer import Customer

router = APIRouter(prefix="/profile", tags=["user-profile"])

@router.get("/me")
def read_profile(current_user: Customer = Depends(get_current_user)):
    """Return current user info."""
    return {
        "cno": current_user.cno,
        "name": current_user.name,
        "email": current_user.email,
    }

