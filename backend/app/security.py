import os
from datetime import datetime, timedelta, timezone

import bcrypt
import jwt

# Set a real secret in an environment variable before deploying.
SECRET_KEY = os.getenv("SECRET_KEY", "dev-only-change-me")
DEV_MODE = os.getenv("DEV_MODE", "1") == "1"
ALGORITHM = "HS256"


def hash_password(password: str) -> str:
    return bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()


def verify_password(password: str, hashed: str) -> bool:
    return bcrypt.checkpw(password.encode(), hashed.encode())


def create_token(user_id: int, role: str) -> str:
    exp = datetime.now(timezone.utc) + timedelta(days=7)
    return jwt.encode(
        {"sub": str(user_id), "role": role, "exp": exp},
        SECRET_KEY,
        algorithm=ALGORITHM,
    )


def decode_token(token: str) -> dict:
    return jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])