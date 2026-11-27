from typing import Literal
from pydantic import BaseModel, Field


class RegisterIn(BaseModel):
    full_name: str = Field(min_length=2, max_length=120)
    contact: str = Field(min_length=5, max_length=120)
    password: str = Field(min_length=6, max_length=72)
    # Admin accounts are NOT self-registered; create them manually.
    role: Literal["elderly", "caregiver"]


class LoginIn(BaseModel):
    contact: str
    password: str


class OtpVerifyIn(BaseModel):
    contact: str
    code: str = Field(min_length=4, max_length=6)


class ContactIn(BaseModel):
    contact: str


class MessageOut(BaseModel):
    message: str
    dev_otp: str | None = None  # only in DEV_MODE


class TokenOut(BaseModel):
    access_token: str
    token_type: str = "bearer"
    role: str


class UserOut(BaseModel):
    id: int
    full_name: str
    contact: str
    role: str
    is_verified: bool

    model_config = {"from_attributes": True}


class ElderProfileIn(BaseModel):
    emergency_name: str | None = None
    emergency_phone: str | None = None
    emergency_relation: str | None = None
    language: str | None = None
    large_font: bool = False
    high_contrast: bool = False


class ElderProfileOut(ElderProfileIn):
    model_config = {"from_attributes": True}