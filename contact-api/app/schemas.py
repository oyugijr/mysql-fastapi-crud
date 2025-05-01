from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime

class ContactBase(BaseModel):
    name: str
    email: EmailStr
    phone: Optional[str] = None

class ContactCreate(ContactBase):
    pass

class Contact(ContactBase):
    contact_id: int
    created_at: datetime

    class Config:
        orm_mode = True
