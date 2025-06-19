# app/crud/customer.py
from sqlalchemy.orm import Session
from app.models.customer import Customer
from app.schemas.customer import CustomerCreate
from app.core.security import get_password_hash, verify_password

def get(db: Session, cno: int) -> Customer | None:
    return db.get(Customer, cno)

def get_by_email(db: Session, email: str) -> Customer | None:
    return db.query(Customer).filter(Customer.email == email).first()

def create(db: Session, obj_in: CustomerCreate) -> Customer:
    db_obj = Customer(
        name=obj_in.name,
        email=obj_in.email,
        passportNumber=obj_in.passportNumber,
        passwd=get_password_hash(obj_in.password),
    )
    db.add(db_obj)
    db.commit()
    db.refresh(db_obj)
    return db_obj

def authenticate(db: Session, email: str, password: str) -> Customer | None:
    user = get_by_email(db, email)
    if user and verify_password(password, user.passwd):
        return user
    return None