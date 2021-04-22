FROM python:3.8

WORKDIR /frontend

COPY requirements.txt .

RUN pip install -r requirements.txt

EXPOSE 5000

ENTRYPOINT [ "python", "app.py"]