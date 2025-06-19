# 관리자 관련 요청과 응답 모델을 정의합니다.
# app/schemas/admin.py
from pydantic import BaseModel

class AdminLogin(BaseModel):
    username: str
    password: str

class AdminOut(BaseModel):
    id: int
    username: str
    is_super: bool
    class Config:
        from_attributes = True
