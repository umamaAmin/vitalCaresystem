import secrets
from datetime import timedelta

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy import delete, select
from sqlalchemy.orm import Session

from ..database import get_db
from ..deps import current_user
from ..models import OtpCode, User, utcnow
from ..schemas import (ContactIn, LoginIn, MessageOut, OtpVerifyIn,
                       RegisterIn, TokenOut, UserOut)
from ..security import (DEV_MODE, create_token, hash_password,
                        verify_password)

router = APIRouter(prefix="/auth", tags=["auth"])


def _issue_otp(db: Session, user: User) -> str:
    code = f"{secrets.randbelow(10000):04d}"
    db.execute(delete(OtpCode).where(OtpCode.user_id == user.id))
    db.add(OtpCode(user_id=user.id, code=code,
                   expires_at=utcnow() + timedelta(minutes=10)))
    db.commit()
    # TODO: send via SMS/email provider. For now it is printed in the console.
    print(f"[OTP] {user.contact}: {code}")
    return code


def _get_user(db: Session, contact: str) -> User | None:
    return db.scalar(select(User).where(User.contact == contact.strip().lower()))


@router.post("/register", response_model=MessageOut, status_code=201)
def register(data: RegisterIn, db: Session = Depends(get_db)):
    contact = data.contact.strip().lower()
    if _get_user(db, contact):
        raise HTTPException(409, "This email/phone is already registered")
    user = User(full_name=data.full_name.strip(), contact=contact,
                password_hash=hash_password(data.password), role=data.role)
    db.add(user)
    db.commit()
    db.refresh(user)
    code = _issue_otp(db, user)
    return MessageOut(message="OTP sent", dev_otp=code if DEV_MODE else None)


@router.post("/resend-otp", response_model=MessageOut)
def resend_otp(data: ContactIn, db: Session = Depends(get_db)):
    user = _get_user(db, data.contact)
    if user is None or user.is_verified:
        raise HTTPException(404, "No pending verification for this contact")
    code = _issue_otp(db, user)
    return MessageOut(message="OTP sent again",
                      dev_otp=code if DEV_MODE else None)


@router.post("/verify-otp", response_model=TokenOut)
def verify_otp(data: OtpVerifyIn, db: Session = Depends(get_db)):
    user = _get_user(db, data.contact)
    if user is None:
        raise HTTPException(404, "User not found")
    otp = db.scalar(select(OtpCode).where(OtpCode.user_id == user.id))
    if otp is None or otp.code != data.code or otp.expires_at < utcnow():
        raise HTTPException(400, "Invalid or expired code")
    user.is_verified = True
    db.execute(delete(OtpCode).where(OtpCode.user_id == user.id))
    db.commit()
    return TokenOut(access_token=create_token(user.id, user.role), role=user.role)


@router.post("/login", response_model=TokenOut)
def login(data: LoginIn, db: Session = Depends(get_db)):
    user = _get_user(db, data.contact)
    if user is None or not verify_password(data.password, user.password_hash):
        raise HTTPException(401, "Wrong email/phone or password")
    if not user.is_verified:
        raise HTTPException(403, "Account not verified. Please verify OTP.")
    return TokenOut(access_token=create_token(user.id, user.role), role=user.role)


@router.get("/me", response_model=UserOut)
def me(user: User = Depends(current_user)):
    return user