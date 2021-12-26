from typing import List
from fastapi import APIRouter, Depends, status, HTTPException
from .. import schemas, database
from sqlalchemy.orm import Session
from ..functions import book

router = APIRouter(prefix="/api/v1/book", tags=["Books"])

get_db = database.get_db


@router.get(
    "/",
    status_code=200,
    response_model=List[schemas.ShowBook],
    # response_model_exclude={"writer" : {"books"}} ,
    response_model_exclude={
        "writer": {"books": {"__all__": {"user_id", "body", "url"}}}
    },
)
def all(db: Session = Depends(get_db)):
    return book.get_all(db)


@router.post("/", status_code=status.HTTP_201_CREATED)
def create(request: schemas.Book, db: Session = Depends(get_db)):
    return book.create(request, db)


@router.delete("/{id}", status_code=status.HTTP_204_NO_CONTENT)
def destroy(id: int, db: Session = Depends(get_db)):
    return book.destroy(id, db)


@router.put("/{id}", status_code=status.HTTP_202_ACCEPTED)
def update(id: int, request: schemas.Book, db: Session = Depends(get_db)):
    return book.update(id, request, db)


@router.get(
    "/{id}",
    status_code=200,
    response_model=schemas.ShowBook,
    response_model_exclude={"writer": {"books": {"__all__": {"user_id"}}}},
)
def show(id: int, db: Session = Depends(get_db)):
    return book.show(id, db)
