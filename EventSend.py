import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from datetime import datetime, date, time

cred = credentials.Certificate('C:/Users/itcub/Documents/GitHub/iOS_Library/smart-library-8a179-firebase-adminsdk-c01sz-f51272754e.json')

# Подключаемся к  БД
firebase_admin.initialize_app(cred)

# Подключаемся
db = firestore.client()

#Вводим информация
#print('Enter name')
#name = input()
#print("Format date: DD-MM-YYYY HH:MM")
#print("Enter date:")
#fdate = input()
#date = datetime.strptime(fdate, "%d-%m-%Y %H:%M")
#print('Add description:')
#description = input()
#print('place:')
#place = input()
#print('communication:')
#communication = input()

# отправка данных
def To_send(name, description, date, place, communication):
    data = {
        u'name': name, 
        u'description': description,
        u'date': date,
        u'place': place,
        u'communication': communication
    }
    db.collection(u'events').add(data)


# To_send(name, description, date, place, communication)
