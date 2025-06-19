# 사용자 로그인과 토큰 응답용 스키마입니다.
# app/schemas/user_auth.py
from pydantic import BaseModel

class UserLogin(BaseModel):
    email: str
    password: str

class TokenOut(BaseModel):
    access_token: str
    token_type: str = "bearer"
