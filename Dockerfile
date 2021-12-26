FROM        python:3-alpine

LABEL       code.author="caiodelgadonew"
LABEL       dockerfile.author="caiodelgadonew"
LABEL       dockerfile.mantainer="caiodelgadonew"

RUN         apk add --no-cache curl ;\
            python3 -m pip install --upgrade pip;\
            adduser -D uvicorn

USER        uvicorn
WORKDIR     /home/uvicorn
ENV         PATH="/home/uvicorn/.local/bin:${PATH}"

COPY        --chown=uvicorn:uvicorn books /home/uvicorn/books

RUN         pip3 install -r books/requirements.txt

EXPOSE      9000 

ENTRYPOINT [ "uvicorn", "books.main:app" ]

CMD        [ "--host", "0.0.0.0", "--port", "9000", "--proxy-headers" ]

