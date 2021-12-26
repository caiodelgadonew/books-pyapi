from typing import List, Optional
from pydantic import BaseModel

class BookBase(BaseModel):
    title: str
    body: str
    url: Optional[str] = None
    language: str
    user_id: str 

class User(BaseModel):
    name: str
    email: str
    website: Optional[str] = None


class Book(BookBase):
    class Config():
        orm_mode = True
        underscore_attrs_are_private = False

class ShowUser(BaseModel):
    name: str
    email: str
    website: str
    books: List[Book]
    class Config():
        orm_mode = True

class ShowBook(BaseModel):
    title: str
    body: str
    writer: ShowUser
    class Config():
        orm_mode = True
