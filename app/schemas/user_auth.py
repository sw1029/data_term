# app/schemas/user_auth.py
from pydantic import BaseModel

class UserLogin(BaseModel):
    email: str
    password: str

class TokenOut(BaseModel):
    access_token: str
    token_type: str = "bearer"
