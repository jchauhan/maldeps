FROM python:3.10-slim-bullseye AS base
LABEL org.opencontainers.image.source="https://github.com/DataDog/attacker/"

RUN addgroup --system --gid 1000 attacker \
    && adduser --system --shell /bin/bash --uid 1000 --ingroup attacker attacker

RUN apt-get update && apt-get install -y git vim unzip zip 

RUN mkdir /app
WORKDIR /app


FROM base as builder
# only copy source for build
#COPY . /app
# install any build time deps + Python deps
RUN --mount=type=cache,mode=0755,id=pip,target=/root/.cache/pip \
    pip install guarddog


FROM base as malicious
# only copy source for build
RUN mkdir -p /app/malicious && mkdir -p /tmp/malicious/pypi
COPY . /app/malicious
RUN mkdir -p /tmp/malicious/pypi && /app/malicious/scripts/remove_passwords.sh /app/malicious/samples/pypi/ /tmp/malicious/pypi


FROM base as app
# copy built deps from builder
COPY --from=builder /usr/local/bin/ /usr/local/bin/
COPY --from=builder --chown=attacker /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=malicious /tmp/malicious /tmp/malicious
COPY --from=malicious /app/malicious /app/malicious
RUN chown -R attacker /app
RUN apt-get install -y libxml2-dev libxslt-dev python-dev make python3-lxml libxml2 build-essential zlib1g-dev

RUN pip install twine
RUN pip install "Cython>=3.0.5"

RUN apt-get install netcat -y
USER attacker

RUN mkdir /home/attacker/.pip
COPY ./docker/pypi/pip.conf /home/attacker/.pip
COPY ./docker/pypi/.pypirc /home/attacker/

RUN cd /app/malicious/others/lxml &&  make wheel

ENTRYPOINT ["/bin/bash"]
