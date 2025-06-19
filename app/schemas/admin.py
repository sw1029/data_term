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
        orm_mode = True
