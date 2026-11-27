from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session

from ..database import get_db
from ..deps import current_user
from ..models import ElderProfile, User
from ..schemas import ElderProfileIn, ElderProfileOut

router = APIRouter(prefix="/profile", tags=["profile"])


def _elder_only(user: User) -> None:
    if user.role != "elderly":
        raise HTTPException(403, "Only elderly users have this profile")


@router.get("/elder", response_model=ElderProfileOut)
def get_elder_profile(user: User = Depends(current_user),
                      db: Session = Depends(get_db)):
    _elder_only(user)
    profile = db.get(ElderProfile, user.id)
    if profile is None:
        raise HTTPException(404, "Profile not set up yet")
    return profile


@router.put("/elder", response_model=ElderProfileOut)
def save_elder_profile(data: ElderProfileIn,
                       user: User = Depends(current_user),
                       db: Session = Depends(get_db)):
    _elder_only(user)
    profile = db.get(ElderProfile, user.id)
    if profile is None:
        profile = ElderProfile(user_id=user.id)
        db.add(profile)
    for field, value in data.model_dump().items():
        setattr(profile, field, value)
    db.commit()
    db.refresh(profile)
    return profile