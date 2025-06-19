# app/crud/admin.py
from sqlalchemy.orm import Session
from app.models.admin import Admin
from app.core.security import get_password_hash, verify_password

def get_by_username(db: Session, username: str) -> Admin | None:
    return db.query(Admin).filter(Admin.username == username).first()

def authenticate(db: Session, username: str, password: str) -> Admin | None:
    admin = get_by_username(db, username)
    if admin and verify_password(password, admin.passwd):
        return admin
    return None

def create(db: Session, username: str, password: str, is_super: bool = False) -> Admin:
    obj = Admin(username=username, passwd=get_password_hash(password), is_super=is_super)
    db.add(obj)
    db.commit()
    db.refresh(obj)
    return obj
