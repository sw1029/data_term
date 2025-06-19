# 고객 데이터 입출력용 Pydantic 스키마입니다.
# app/schemas/customer.py
from pydantic import BaseModel, EmailStr

class CustomerBase(BaseModel):
    name: str
    email: EmailStr
    passportNumber: str

class CustomerCreate(CustomerBase):
    password: str

class CustomerOut(CustomerBase):
    cno: int
    class Config:
        orm_mode = True
