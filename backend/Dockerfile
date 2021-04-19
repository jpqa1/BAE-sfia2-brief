# This is the image that our backend container will be built from.
FROM python:3.6

COPY . . 

RUN pip install -r requirements.txt

EXPOSE 5001

ENTRYPOINT [ "python3", "app.py" ]