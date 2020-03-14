import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from datetime import datetime, date, time

cred = credentials.Certificate('C:/Users/Влад/Downloads/test-dfa5f-firebase-adminsdk-i65lc-31ead13503.json')

# Подключаемся к  БД
firebase_admin.initialize_app(cred)

# Подключаемся
db = firestore.client()

docs = db.collection(u'events').stream()

#Вводим информация
print('Enter name')
name = input()
print("Format date: DD-MM-YYYY HH:MM")
print("Enter date:")
fdate = input()
date = datetime.strptime(fdate, "%d-%m-%Y %H:%M")
print('Add description')
description = input()
doc = db.collection(u'events').document(u'first event').get().to_dict()
print(doc['date'])

def To_send():
    datetime.now()
    doc_ref = db.collection(u'event').document('ADA')
    doc_ref.set({
        u'name': name,        
        u'description': '',
        u'date': date
    })
To_send()
