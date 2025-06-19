# FastAPI 애플리케이션의 엔트리 포인트입니다.
# app/main.py
from fastapi import FastAPI
from app.api.v1 import (
    customer,
    flight,
    seat,
    reservation,
    admin_auth,
    admin_panel,
    user_auth,
    user_profile,
)

app = FastAPI(title="db_term API", version="0.1.0")

app.include_router(customer.router, prefix="/api")
app.include_router(flight.router, prefix="/api")
app.include_router(seat.router, prefix="/api")
app.include_router(reservation.router, prefix="/api")
app.include_router(admin_auth.router, prefix="/api")
app.include_router(admin_panel.router, prefix="/api")
# 실행: uvicorn app.main:app --reload
app.include_router(user_auth.router, prefix="/api")
app.include_router(user_profile.router, prefix="/api")
