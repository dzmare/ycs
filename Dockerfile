
FROM python:3.8 AS builder
COPY requirements.txt .
RUN pip install --user -r requirements.txt

FROM python:3.8-slim


WORKDIR /code

# copy only the dependencies installation from the 1st stage image
COPY --from=builder /root/.local /root/.local
COPY app.py .
COPY error_logging.py .

RUN apt-get update && apt-get upgrade --no-install-recommends --no-install-suggests -y

CMD [ "python", "./app.py"]