from sqlalchemy import Column, Integer, String, ForeignKey
from database import Base
from sqlalchemy.orm import relationship

class Book(Base):
    __tablename__ = "books"
    
    id = Column(Integer, primary_key=True, index=True)
    title = Column(String)
    body = Column(String)
    url = Column(String)
    language = Column(String)
    user_id = Column(Integer, ForeignKey("users.id"))

    writer = relationship("User", back_populates="books")

class User(Base):
    __tablename__ = "users"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    email = Column(String)
    website = Column(String)

    books = relationship("Book", back_populates="writer")

