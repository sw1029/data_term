# 관리자 인증을 처리하는 라우터 모듈입니다.
# app/api/v1/admin_auth.py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.schemas.admin import AdminLogin
from app.crud import admin as crud_admin
from app.core.security import create_access_token
from app.database import get_db

router = APIRouter(prefix="/admin", tags=["admin-auth"])

@router.post("/login")
def admin_login(payload: AdminLogin, db: Session = Depends(get_db)):
    admin = crud_admin.authenticate(db, payload.username, payload.password)
    if not admin:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Bad credentials")
    token = create_access_token(sub=str(admin.id), role="ADMIN")
    return {"access_token": token, "token_type": "bearer"}
