#!/bin/bash
# populate example users 

APP_SERVER="${SERVER:=localhost}" 
APP_PORT="${PORT:=9000}"

populate_users() {
  curl -fsSLX 'POST' \
    'http://'"$APP_SERVER"':'"$APP_PORT"'/api/v1/user/' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
    "name": "Caio Delgado",
    "email": "caio@caiodelgadonew.example",
    "website": "lintkr.ee/caiodelgadonew"
  }';echo 

  curl -fsSLX 'POST' \
    'http://'"$APP_SERVER"':'"$APP_PORT"'/api/v1/user/' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
    "name": "Google",
    "email": "sre@google.com",
    "website": "sre.google/books"
  }'; echo 
}

populate_books() {
  curl -fsSLX 'POST' \
    'http://'"$APP_SERVER"':'"$APP_PORT"'/api/v1/book/' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
    "title": "Docker DCA",
    "body": "If you'\''ve ever tried to learn about containers but found the language complicated, this book is for you, here I show you everything with simple examples and clear explanations, everything so you can start your journey in containers, and if you already know docker , this book is also for you who are looking to specialize in this subject.",
    "url": "leanpub.com/dockerdca",
    "language": "PT-BR",
    "user_id": 1
  }'; echo 

  curl -fsSLX 'POST' \
    'http://'"$APP_SERVER"':'"$APP_PORT"'/api/v1/book/' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
    "title": "Site Reliability Engineering",
    "body": "Members of the SRE team explain how their engagement with the entire software lifecycle has enabled Google to build, deploy, monitor, and maintain some of the largest software systems in the world.",
    "url": "https://sre.google/sre-book/table-of-contents/",
    "language": "EN-US",
    "user_id": 2
  }'; echo 

  curl -fsSLX 'POST' \
    'http://'"$APP_SERVER"':'"$APP_PORT"'/api/v1/book/' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
    "title": "The Site Reliability Workbook",
    "body": "The Site Reliability Workbook is the hands-on companion to the bestselling Site Reliability Engineering book and uses concrete examples to show how to put SRE principles and practices to work. This book contains practical examples from Google’s experiences and case studies from Google’s Cloud Platform customers. Evernote, The Home Depot, The New York Times, and other companies outline hard-won experiences of what worked for them and what didn’t.",
    "url": "https://sre.google/workbook/table-of-contents/",
    "language": "EN-US",
    "user_id": 2
  }'; echo 

  curl -fsSLX 'POST' \
    'http://'"$APP_SERVER"':'"$APP_PORT"'/api/v1/book/' \
    -H 'accept: application/json' \
    -H 'Content-Type: application/json' \
    -d '{
    "title": "Building Secure & Reliable Systems",
    "body": "Can a system be considered truly reliable if it isn'\''t fundamentally secure? Or can it be considered secure if it'\''s unreliable? Security is crucial to the design and operation of scalable systems in production, as it plays an important part in product quality, performance, and availability. In this book, experts from Google share best practices to help your organization design scalable and reliable systems that are fundamentally secure.",
    "url": "https://static.googleusercontent.com/media/sre.google/en//static/pdf/building_secure_and_reliable_systems.pdf",
    "language": "EN-US",
    "user_id": 2
  }'; echo 
}


if [[ -z $SERVER ]] ;
then
  echo "ERROR: Environment variable SERVER is not defined!"
  echo "ERROR: Please be sure to define $SERVER before running the script"
  exit 1
else
  IS_POPULATED=`curl -s -o /dev/null -w "%{http_code}" -X 'GET' 'http://'"$APP_SERVER"':'"$APP_PORT"'/api/v1/user/1'`
fi

if [ $IS_POPULATED == "200" ]
then
  echo "Database is already populated"
  exit 0
else
  echo "Populating Users"
  populate_users
  echo "Populating Database"
  populate_books
  exit 0
fi
