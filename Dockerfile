FROM ubuntu:14.04
MAINTAINER PhenoMeNal-H2020 Project <phenomenal-h2020-users@googlegroups.com>

LABEL Description="Galaxy 17.05-phenomenal for running inside Kubernetes."
LABEL software="Galaxy"
LABEL software.version="17.05-pheno-lr"
LABEL version="1.4"

RUN apt-get -qq update && apt-get install --no-install-recommends -y apt-transport-https software-properties-common wget && \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y mercurial python-psycopg2 sudo python-virtualenv \
    libyaml-dev libffi-dev libssl-dev \
    curl git python-pip python-gnuplot python-psutil && \
    pip install --upgrade pip && \
    apt-get purge -y software-properties-common && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN git clone --depth 1 --single-branch --branch 17.05_fs_supp-res_lim_req-isa https://github.com/phnmnl/galaxy.git
WORKDIR galaxy
RUN echo "pykube==0.15.0" >> requirements.txt
COPY config/galaxy.ini config/galaxy.ini
COPY config/job_conf.xml config/job_conf.xml
COPY config/tool_conf.xml config/tool_conf.xml
COPY config/sanitize_whitelist.txt config/sanitize_whitelist.txt
COPY config/job_resource_params_conf.xml config/job_resource_params_conf.xml
COPY config/phenomenal_tools2container.yaml config/phenomenal_tools2container.yaml

# Galaxy tours which guide users through the subsequent steps in an analysis
COPY config/plugins/tours/metfrag+xcms-tour.yaml config/plugins/tours/metfrag+xcms-tour.yaml

COPY rules/k8s_destinations.py lib/galaxy/jobs/rules/k8s_destination.py
COPY tools/phenomenal tools/phenomenal

RUN virtualenv .config_script_venv
RUN /bin/bash -c "source .config_script_venv/bin/activate && \
                  pip install bioblend==0.9.0 && \
                  deactivate"

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

# Missing XCMS datatypes for w4m
COPY external-datatypes/rdata_xcms_datatype.py /galaxy/lib/galaxy/datatypes/
COPY external-datatypes/rdata_camera_datatype.py /galaxy/lib/galaxy/datatypes/
COPY external-datatypes/no_unzip_datatypes.py /galaxy/lib/galaxy/datatypes/
COPY external-datatypes/nmrml_datatype.py /galaxy/lib/galaxy/datatypes/
COPY config/datatypes_conf.xml config/datatypes_conf.xml

EXPOSE 8080

CMD ["./run.sh"]
