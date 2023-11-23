FROM python:3.10-slim-bullseye AS base

RUN addgroup --system --gid 1000 victim \
    && adduser --system --shell /bin/bash --uid 1000 --ingroup victim victim

RUN apt-get update && apt-get install -y git vim unzip zip 

RUN mkdir /app
WORKDIR /app


RUN chown -R victim /app
RUN apt-get install -y libxml2-dev libxslt-dev python-dev make python3-lxml libxml2 build-essential zlib1g-dev
RUN apt-get install netcat -y

RUN pip install twine
RUN pip install "Cython>=3.0.5"

USER victim

RUN mkdir /home/victim/.pip
COPY ./pip.conf /home/victim/.pip/
ENTRYPOINT ["/bin/bash"]

