FROM ubuntu:14.04
MAINTAINER PhenoMeNal-H2020 Project <phenomenal-h2020-users@googlegroups.com>

LABEL Description="Galaxy 16.07-phenomenal for running inside Kubernetes."
LABEL software="Galaxy"
LABEL software.version="16.07-pheno"
LABEL version="0.2"

RUN apt-get -qq update && apt-get install --no-install-recommends -y apt-transport-https software-properties-common wget && \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y mercurial python-psycopg2 sudo python-virtualenv \
    libyaml-dev libffi-dev libssl-dev \
    curl git python-pip python-gnuplot python-psutil && \
    pip install --upgrade pip && \
    apt-get purge -y software-properties-common && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN git clone --depth 1 --single-branch --branch feature/allfeats_no_interpreter_removal https://github.com/phnmnl/galaxy.git
WORKDIR galaxy
RUN echo "-e git+https://github.com/pcm32/pykube.git@feature/allMergedFeatures#egg=pykube" >> requirements.txt
COPY config/galaxy.ini config/galaxy.ini
COPY config/job_conf.xml config/job_conf.xml
COPY config/tool_conf.xml config/tool_conf.xml
COPY tools/phenomenal tools/phenomenal

RUN virtualenv .venv
RUN /bin/bash -c "source .venv/bin/activate && \
                  pip install 'pip>=8.1' && \
                  pip install -r requirements.txt \
                      --index-url https://wheels.galaxyproject.org/simple && \
                  deactivate"

# Galaxy runs on python < 3.5, so https://github.com/kelproject/pykube/issues/29 recommends
ENV PYKUBE_KUBERNETES_SERVICE_HOST kubernetes

COPY html/partners.png static/partners.png
COPY html/PhenoMeNal_logo.png static/PhenoMeNal_logo.png
COPY html/welcome.html static/welcome.html
COPY ansible ansible
COPY workflows workflows
COPY container-simple-checks.sh container-simple-checks.sh
COPY test_cmds.txt test_cmds.txt
RUN chmod u+x /galaxy/ansible/run_galaxy_config.sh

EXPOSE 8080

CMD ["./run.sh"]
