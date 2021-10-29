FROM python:3.8-slim-buster
COPY requirements.txt requirements.txt
ADD wallet.py api.py /
RUN pip install -r requirements.txt
CMD [ "python", "./api.py" ]
