from sqlalchemy import Column, Integer, String, ForeignKey
from .database import Base
from sqlalchemy.orm import relationship


class Book(Base):
    __tablename__ = "books"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String(200))
    body = Column(String(1000))
    url = Column(String(300))
    language = Column(String(20))
    user_id = Column(Integer, ForeignKey("users.id"))

    writer = relationship("User", back_populates="books")


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100))
    email = Column(String(100))
    website = Column(String(100))

    books = relationship("Book", back_populates="writer")
