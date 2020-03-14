#Программа для нахождения и записи средней оценки в БД
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("C:/Users/itcub/Documents/GitHub/iOS_Library/smart-library-8a179-firebase-adminsdk-c01sz-f51272754e.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

current_id_book = ''

# Автоматическая запись средней оценки в БД
def write_rating_to_firestore(rating, id_book):
    db.collection('books').document(id_book).update(
        {
            "score": rating
        }
    )

# ГФ передать ID книги
def averange (id_book):
    docs = db.collection(u'scores').stream()

    averange = 0
    scores = count = 0

    # Look at docs
    for doc in docs:        
        a = db.collection(u'scores').document(doc.id).get().to_dict()
        if a['id_book'] == id_book:
            for key, value in doc.to_dict().items():
                if key == 'score':
                    scores += value
                    count += 1
    write_rating_to_firestore(round(scores / count, 1), id_book)

#Test
#averange('74|Ф 97-303586')
