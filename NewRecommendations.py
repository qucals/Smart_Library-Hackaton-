import math
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Ссылка на секретный ключ
cred = credentials.Certificate('D:/fe/github/iOS_Library/iOS_Library/smart-library-1-firebase-adminsdk-g8x7r-2d069f053c.json')

# Подключаемся к  БД
firebase_admin.initialize_app(cred)

# Подключаемся
db = firestore.client()

#Находим сколько книг уже имеется
docs = db.collection(u'books').stream()

# Считать информация из CSV файла (IDuser, IDbook, Rates)
# Возвращает структуру данных dict: каждому пользователю ставится в соответствие справочник его оценок вида «продукт»:«оценка».
def ReadFile (docs):
    mentions = dict()
    k=0
    for doc in docs:
        for key, value in doc.to_dict().items():
            if key == 'scores':
                for score in value:
                    for key, value in score.items():                        
                        if not score['id_user'] in mentions:
                            mentions[score['id_user']] = dict()
                        if str(score['score']) == 'None':
                            break
                        if score['score'] <= 5 and score['score'] >= 0:
                            print(score['score'])
                            mentions[score['id_user']][doc.id] = float(score['score'])
                                        
        k+=1
    print(mentions)
    return mentions

# Функция "Косинусная мера схожести"
def distCosine (vecA, vecB):
    def dotProduct (x, y):
        d = 0.0
        for dim in x:
            if dim in y:
                d += (x[dim])*(y[dim]) #производим нормализацию оценок, вычтя из оценки мат. ожидание (условно 3.0)
        return d    
    return abs(dotProduct (vecA, vecB) / math.sqrt(dotProduct(vecA,vecA)) / math.sqrt(dotProduct(vecB,vecB)))

# Основная функция makeRecommendation
# userID - ID пользователя, для которого ищем рекомендации
# userRates - Оценки пользователей (ReadFile)
# nBestUsers - Кол-во пользователей которых мы выделяем, как наиболее схожих во вкусах
# nBestBook - Кол-во книг, которые мы будем рекомендовать пользователю
def makeRecommendation (userID, userRates, nBestUsers, nBestBook):
    matches = [(u, distCosine(userRates[userID], userRates[u])) for u in userRates if u != userID] # записываем соотношение вкусов Users к позователю
    bestMatches = sorted(matches, key = lambda x: (x[1], x[0]), reverse=True)[:nBestUsers] #Выделям и сортируем лучших nBestUsers()
    print ("Most correlated with '%s' users:" % userID)
    for line in bestMatches:
        print ("  UserID: %6s  Coeff: %6.4f" % (line[0], line[1]))    
    sim = dict()# sim -  выбранная нами мера схожести двух пользователей
    sim_all = sum([x[1] for x in bestMatches])
    bestMatches = dict([x for x in bestMatches if x[1] > 0.0])
    for relatedUser in bestMatches:
        for book in userRates[relatedUser]:
            if not book in userRates[userID]:
                if not book in sim:
                    sim[book] = 0.0
                sim[book] += userRates[relatedUser][book] * bestMatches[relatedUser]
    for book in sim:
        sim[book] /= sim_all
    bestBook = sorted(sim.items(),  key = lambda x: (x[1], x[0]), reverse=True)[:nBestBook]
    print ("Most correlated products:")
    for prodInfo in bestBook:    
        print ("  ProductID: %6s  CorrelationCoeff: %6.4f" % (prodInfo[0], prodInfo[1]))
    return [(x[0], x[1]) for x in bestBook]


# Тест
name = 'ew'
rec = makeRecommendation (name, ReadFile(docs), 5, 5)
