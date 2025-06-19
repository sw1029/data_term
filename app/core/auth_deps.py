# app/core/auth_deps.py
from fastapi import Depends, Header, HTTPException, status
from sqlalchemy.orm import Session
from app.core.security import parse_token
from app.database import get_db
from app.models.admin import Admin
from app.models.customer import Customer

def _extract_token(authorization: str | None) -> str:
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Missing bearer token")
    return authorization.split(" ", 1)[1]

def get_current_admin(
    authorization: str = Header(None), db: Session = Depends(get_db)
) -> Admin:
    token = _extract_token(authorization)
    payload = parse_token(token)
    if payload.get("role") != "ADMIN":
        raise HTTPException(status_code=403, detail="Not an admin token")
    admin = db.get(Admin, int(payload["sub"]))
    if not admin:
        raise HTTPException(status_code=404, detail="Admin not found")
    return admin

def admin_required(current: Admin = Depends(get_current_admin)):
    # 추가 권한 분기 필요 시 여기에서 is_super 검사
    return current
def get_current_user(
    authorization: str = Header(None),
    db: Session = Depends(get_db)
) -> Customer:
    token = _extract_token(authorization)
    payload = parse_token(token)
    if payload.get("role") not in {"USER", "ADMIN"}:   # ADMIN 토큰도 허용할지 결정
        raise HTTPException(status_code=403, detail="Invalid role for user scope")
    user = db.get(Customer, int(payload["sub"]))
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user

def user_required(current_user: Customer = Depends(get_current_user)):
    return current_user