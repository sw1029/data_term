# 일반 사용자 인증을 담당하는 라우터 모듈입니다.
# app/api/v1/user_auth.py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.schemas.user_auth import UserLogin, TokenOut
from app.crud import customer as crud_customer
from app.core.security import create_access_token
from app.database import get_db

router = APIRouter(prefix="/users", tags=["user-auth"])

@router.post("/login", response_model=TokenOut)
def user_login(payload: UserLogin, db: Session = Depends(get_db)):
    user = crud_customer.authenticate(db, payload.email, payload.password)
    if not user:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED, detail="Bad credentials")
    token = create_access_token(sub=str(user.cno), role="USER")
    return {"access_token": token}
