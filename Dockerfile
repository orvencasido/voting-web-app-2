FROM ubuntu:22.04

RUN apt update && apt install -y \
	python3-pip python3-dev redis-server curl 

RUN pip3 install flask redis

COPY app /app
WORKDIR /app

CMD ["python3", "main.py"]
