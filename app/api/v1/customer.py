# app/api/v1/customer.py
from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from app.schemas.customer import CustomerCreate, CustomerOut
from app.crud import customer as crud_customer
from app.database import get_db

router = APIRouter(prefix="/customers", tags=["customers"])

@router.post("/", response_model=CustomerOut, status_code=status.HTTP_201_CREATED)
def create_customer(payload: CustomerCreate, db: Session = Depends(get_db)):
    if crud_customer.get_by_email(db, payload.email):
        raise HTTPException(status_code=400, detail="E-mail already registered")
    return crud_customer.create(db, payload)

@router.get("/{cno}", response_model=CustomerOut)
def read_customer(cno: int, db: Session = Depends(get_db)):
    db_obj = crud_customer.get(db, cno)
    if not db_obj:
        raise HTTPException(status_code=404, detail="Customer not found")
    return db_obj
