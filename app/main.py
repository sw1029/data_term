# app/main.py
from fastapi import FastAPI
from app.api.v1 import customer, flight, seat, admin_auth, admin_panel, user_auth, user_profile

app = FastAPI(title="db_term API", version="0.1.0")

app.include_router(customer.router)
app.include_router(flight.router)
app.include_router(seat.router)
app.include_router(admin_auth.router)
app.include_router(admin_panel.router)
# 실행: uvicorn app.main:app --reload
app.include_router(user_auth.router)
app.include_router(user_profile.router)
