FROM python:3.8

WORKDIR /backend

COPY requirements.txt .

RUN pip install -r requirements.txt

EXPOSE 5001

ENTRYPOINT [ "python", "app.py"]