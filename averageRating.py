import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

cred = credentials.Certificate("smart-library-8a179-firebase-adminsdk-c01sz-faf86e5022.json")
firebase_admin.initialize_app(cred)

db = firestore.client()

current_id_book = ''

def write_rating_to_firestore(rating):
    db.collection('books').document(current_id_book).update(
        {
            "score": rating
        }
    )

def compute_recommendations(scores):
    result = 0.0
    count = 0

    for score in scores:
        for key, value in score.items():
            if key == 'score' and value is not None:
                result += value
                count += 1
    
    if count != 0:
        return result // count
    else:
        return 0.0

if __name__ == "__main__":
    docs = db.collection(u'books').stream()

    # Look at docs
    for doc in docs:
        current_id_book = doc.id

        # Divide a direction on key & value
        for key, value in doc.to_dict().items():
            # If a direction is scores then we handle by another way
            if key == 'scores':
                rating = compute_recommendations(value)
                write_rating_to_firestore(rating)
                print(u'rating: {}'.format(rating))
            else:
                print(u'{} : {}'.format(key, value))

        print('-----------------------------------\n')
