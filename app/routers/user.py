from fastapi import APIRouter, Depends, Response, status
import database, schemas
from sqlalchemy.orm import Session
from functions import user

router = APIRouter(
    prefix="/api/v1/user",
    tags=["Users"]
)


get_db = database.get_db

@router.post(
    "/", 
    response_model=schemas.ShowUser
    )
def create_user(request: schemas.User, db: Session = Depends(get_db)):
    return user.create(request,db)

@router.get(
    "/{id}", 
    status_code=status.HTTP_200_OK, 
    response_model=schemas.ShowUser, 
    response_model_exclude={"books": {"__all__": {"user_id"}}}
    )
def show(id:int, response: Response, db: Session = Depends(get_db)):
    return user.show(id,db)
