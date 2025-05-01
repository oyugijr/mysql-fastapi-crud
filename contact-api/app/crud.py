from sqlalchemy.orm import Session
from . import models, schemas

def get_contacts(db: Session):
    return db.query(models.Contact).all()

def get_contact(db: Session, contact_id: int):
    return db.query(models.Contact).filter(models.Contact.contact_id == contact_id).first()

def create_contact(db: Session, contact: schemas.ContactCreate):
    new_contact = models.Contact(**contact.dict())
    db.add(new_contact)
    db.commit()
    db.refresh(new_contact)
    return new_contact

def update_contact(db: Session, contact_id: int, updated: schemas.ContactCreate):
    contact = get_contact(db, contact_id)
    if contact:
        for key, value in updated.dict().items():
            setattr(contact, key, value)
        db.commit()
        db.refresh(contact)
    return contact

def delete_contact(db: Session, contact_id: int):
    contact = get_contact(db, contact_id)
    if contact:
        db.delete(contact)
        db.commit()
    return contact
