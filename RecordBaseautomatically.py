# Программа для автоматической записи информации из IRBIS в БД Firebase
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore

# Ссылка на секретный ключ
cred = credentials.Certificate('C:/Users/itcub/Documents/GitHub/iOS_Library/smart-library-8a179-firebase-adminsdk-c01sz-f51272754e.json')

# Подключаемся к  БД
firebase_admin.initialize_app(cred)

# Подключаемся
db = firestore.client()

#Находим сколько книг уже имеется
docs = db.collection(u'NewBook').stream()

# документ типа TXT из которой будем считывать БД IRBIS
f = open('C:/Users/itcub/Documents/GitHub/iOS_Library/Base_Irbis.TXT',encoding = 'utf-8')

p = 0

#подключаем и считываем данные
#Запись
def send(ID, name, Author,publisher,date, bib):
    doc_ref = db.collection(u'NewBook').document(ID)
    doc_ref.set({
        u'name': name,
        u'id_user': '',
        u'available': True,
        u'author': Author,
        u'id_library': bib,
        u'date': date,
        u'publisher': publisher,
        u'description': '',
        u'score': 0
    })
    
def name():
    fID = ''
    fname = ''
    fauthor = ''
    fpublisher = ''
    fdate = ''
    fbib = ''
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
        #Название библиотеки
        if(result[1]+result[2]+result[3] == '902'):
            i = 8
            a = len(line)
            while i != a:                
                fbib+= result[i]
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
            print(fID)
        #находим имя автора
        if(result[1]+result[2]+result[3] == '700'):
            i = 8
            a = len(line)
            while i != a-1:
                if result[i] == '^':
                    fauthor += ' '
                    i+=1
                    while result[i] != '^':
                        i+=1
                    i+=2
                    while i != a:
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
    send(fID, fname, fauthor, fpublisher, fdate, fbib)
            
#Тест
#ГЦ для записи
#for line in f:
#    
#    if line != " ":
#        name()
 
