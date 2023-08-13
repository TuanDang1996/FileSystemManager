FROM python:3.9.17-alpine3.18

WORKDIR /app

COPY ./source .

RUN mkdir uploads

RUN pip3 install pipenv==2022.1.8
RUN pipenv lock -r > requirement.txt
RUN pip3 install -r requirement.txt

EXPOSE 5000
CMD [ "flask", "run","--host","0.0.0.0","--port","5000"]