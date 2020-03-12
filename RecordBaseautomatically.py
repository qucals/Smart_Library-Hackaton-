import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Ссылка на секретный ключ
cred = credentials.Certificate('D:/fe/smart-library-1-firebase-adminsdk-g8x7r-2d069f053c.json')

# Подключаемся к  БД
firebase_admin.initialize_app(cred)

# Подключаемся
db = firestore.client()

#Находим сколько книг уже имеется
docs = db.collection(u'NewBook').stream()

f = open('D:/fe/github/iOS_Library/iOS_Library/Base_Irbis.TXT',encoding = 'utf-8')

p = 0

#подключаем и считываем данные
#Запись
def send(ID, name, Author,publisher,date,k):
    doc_ref = db.collection(u'NewBook').document(ID)
    doc_ref.set({
        u'Name': name,
        u'IDauthor': k+1,
        u'Author': Author,
        u'date': date,
        u'publisher': publisher
    })
    
def name(k):
    fID = ''
    fname = ''
    fauthor = ''
    fpublisher = ''
    fdate = ''    
    for line in f:        
        result = list(line)
        #находим конец списка
        if(result[1]+result[2]+result[3] == '***'):
            break
        #находим издателя
        if(result[1]+result[2]+result[3] == '210'):
            i = 8
            a = len(line)-1
            while i != a:
                if result[i] == '^':
                    i+=2
                    while i != a:
                        if result[i] == '^':
                            i+= 2
                            while i != a:
                                fdate += result[i]
                                i+=1
                            break
                        i+=1
                    break
                fpublisher+= result[i]
                i+=1
        #находим название книги
        if(result[1]+result[2]+result[3] == '200'):
            i = 8
            a = len(line)
            while i != a:
                if result[i] == '^':
                    break
                fname+= result[i]
                i+=1
        #находим ББК
        if(result[1]+result[2]+result[3] == '903'):
            i = 6
            a = len(line) - 1
            
            while i != a:
                if result[i] == '/':
                    fID+= '|'
                    i+=1
                fID+= result[i]
                i+=1
                print(result[i])
            print(fID)
        #находим имя автора
        if(result[1]+result[2]+result[3] == '700'):
            i = 8
            a = len(line)
            while i != a-1:
                if result[i] == '^':
                    i+=9
                    fauthor += '_'
                    while i != a:
                        if result[i] == ' ':
                            fauthor += '_'
                            i+= 1
                        fauthor += result[i]
                        i+=1
                        if (i==a):
                            break
                        if(result[i] == '^'):
                            break                                        
                if i==a:
                    break
                if(result[i] == '^'):
                    break   
                fauthor += result[i]              
                i+=1            
    send(fID, fname, fauthor, fpublisher, fdate,k)
            
k=0
for line in f:
    
    for doc in docs:
        k+=1
    if line != " ":
        a = name(k)
    k+=1
