# README

## Тестовая задание от Кирилла Подгорного

"Создать api для авторизации(регистрация и логин), добавить админку со списком пользователей, которых можно редактировать (дизайн простейший или на свое усмотрение). Добавить в апи метод для создания пользователем заметки, которая будет сохранятся в текстовом виде, со временем, когда пользователь хочет получить напоминание об этой заметке. Для напоминания реализовать функционал пуш-уведомлений, на iOS или Android на выбор. Ко всему вышеперечисленному реализовать документацию API."

## Приступая к работе

Проверьте версии
```
$ ruby -v  # ruby 2.5.1
$ rails -v # rails 6.0.3.1
```

### Установка

##### Склонируйте репозиторий
```
$ git@github.com:Esgeri/kirill_test_api_app.git
```

##### Установите гемы
```
$ bundle install
```

##### Установка Rpush
```
rpush init
```

##### Создание базы данных
```
rails db:createL:all
```

##### Создание миграции
```
$ rake db:migrate
```

##### Создание сидов
```
$ rake db:seed
```

##### Пользователь администратор
```
Email: 'admin@example.com'
Password: 'password'
```


##
## Документирование API
Интеграция нашего API в свое приложение для получения данных.

**Регистрация**
```
url:/signup
method:'POST'
parameters body:email[required], password[required], password_confirmation[required]
```

**Логин**
```
url:/login
method:'POST'
parameters body:email[required], password[required]
```

**Декодирование токена. Проверка**
```
url:/decoding_token
method:'GET'
parameters body:auth_token[required]
```

**Создание заметки пользователем**
```
url:/notifications
method:'POST'
parameters body:title[required],body[required],push_time[required],auth_token[required]
```

**Отправка заметки**
```
url:/notification/notify
method:'GET'
parameters body:auth_token[required]
```

Для отправки запроса можно применить консольное приложение [httpie](https://httpie.org/)

## Примеры вызовов API

**Регистрация пользователя**
```
method: ‘POST’
url: localhost:3000/signup
```

**Параметры**
```
email: john@mail.com
password: foobar
```

**Запрос**
```
http :3000/signup email=john@mail.com password=foobar password_confirmation=foobar
```

**Результат**
```
{
    "auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.V0z1TcfuH6MgWtsXxcz0cejD1e6ES3lvfF6uqtU6CAg"
}
```

#

**Логин**
```
method: ‘POST’
url: localhost:3000/login
```

**Параметры**
```
email: john@mail.com
password: foobar
```

**Запрос**
```
http :3000/login email=john@mail.com password=foobar
```

**Результат**
```
{
    "auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.V0z1TcfuH6MgWtsXxcz0cejD1e6ES3lvfF6uqtU6CAg"
}
```

#

**Декодирование токена. Проверка**
```
method: ‘GET’
url: localhost:3000/decoding_token
```

**Параметры**
```
auth_token: Authorization:"Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.V0z1TcfuH6MgWtsXxcz0cejD1e6ES3lvfF6uqtU6CAg"
```

**Запрос**
```
http GET :3000/decoding_token Authorization:"Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.V0z1TcfuH6MgWtsXxcz0cejD1e6ES3lvfF6uqtU6CAg"
```

**Результат**
```
{
    "created_at": "2020-05-23T05:43:18.062Z", 
    "email": "john@mail.com", 
    "id": 1, 
    "updated_at": "2020-05-23T05:43:18.062Z"
}
```

#

**Создание заметки**
```
method: ‘POST’
url: localhost:3000/notifications
```

**Параметры**
```
title: Title
body: Nbody
push_time: 2020-05-24 09:19:55
auth_token: Authorization:"Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.V0z1TcfuH6MgWtsXxcz0cejD1e6ES3lvfF6uqtU6CAg"
```

**Запрос**
```
http POST :3000/notifications title=Title body=Nbody push_time=2020-05-24 09:19:55 Authorization:"Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.V0z1TcfuH6MgWtsXxcz0cejD1e6ES3lvfF6uqtU6CAg"
```

**Результат**
```
{
    "body": "Nbody", 
    "created_at": "2020-05-24T08:23:12.594Z", 
    "id": 3, 
    "push_time": "2020-05-24T00:00:00.000Z", 
    "title": "Title", 
    "updated_at": "2020-05-24T08:23:12.594Z", 
    "user_id": 1
}
```

#

**Отправка заметки**
```
method: ‘GET’
url: localhost:3000/notifications/notify
```

**Параметры**
```
auth_token: Authorization:"Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.V0z1TcfuH6MgWtsXxcz0cejD1e6ES3lvfF6uqtU6CAg"
```

**Запрос**
```
http GET :3000/notification/notify Authorization:"Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.V0z1TcfuH6MgWtsXxcz0cejD1e6ES3lvfF6uqtU6CAg"
```

**Результат**
```
{
    "sent": true
}
```

##
__Note:__ Rails Api Test App

### Author

* **Mirbek Askerov's** - [Resume](https://esgeri.github.io/cv)
