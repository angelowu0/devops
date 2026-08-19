FROM python:3.12-slim
WORKDIR /app
COPY app.py .
EXPOSE 5000

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

CMD [ "python3", "app.py" ]