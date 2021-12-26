FROM        python:3-alpine

LABEL       code.author="caiodelgadonew"
LABEL       dockerfile.author="caiodelgadonew"
LABEL       dockerfile.mantainer="caiodelgadonew"

WORKDIR     / 
COPY        books /books

RUN         apk add --no-cache curl ;\
            pip3 install -r books/requirements.txt

EXPOSE      9000 

ENTRYPOINT [ "uvicorn", "books.main:app" ]

CMD        [ "--host", "0.0.0.0", "--port", "9000", "--proxy-headers" ]

