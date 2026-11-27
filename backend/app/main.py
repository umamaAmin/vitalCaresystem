from fastapi import FastAPI
from starlette.middleware.cors import CORSMiddleware

from .database import Base, engine
from .routers import auth, profile

Base.metadata.create_all(bind=engine)

app = FastAPI(title="Health Mate API")

# Open CORS is fine for development (Flutter web in Chrome). Restrict later.
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router)
app.include_router(profile.router)


@app.get("/")
def health():
    return {"status": "ok", "app": "Health Mate API"}