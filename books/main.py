from fastapi import FastAPI
from fastapi.encoders import jsonable_encoder
from . import models
from .database import engine
from .logger import _setup_logging
from .routers import book, user

log = _setup_logging()

app = FastAPI(openapi_url="/api/v1/openapi.json", docs_url="/", redoc_url="/docs")

models.Base.metadata.create_all(engine)


@app.get("/api/v1/health", tags=["Health"])
def health_up():
    return {"status": "UP"}


app.include_router(book.router)
app.include_router(user.router)
