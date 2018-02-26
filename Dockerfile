FROM ubuntu:14.04
MAINTAINER PhenoMeNal-H2020 Project <phenomenal-h2020-users@googlegroups.com>

LABEL Description="Galaxy 17.09-phenomenal for running inside Kubernetes."
LABEL software="Galaxy"
LABEL software.version="17.09-pheno-lr"
LABEL version="1.5"


RUN apt-get -qq update && apt-get install --no-install-recommends -y apt-transport-https software-properties-common wget && \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y \
              curl \
              git \
              libffi-dev \
              libssl-dev \
              libyaml-dev \
              mercurial \
              python-gnuplot \
              python-pip \
              python-psutil \
              python-psycopg2 \
              python-virtualenv \
              sudo \
    && \
    pip install --upgrade pip && \
    apt-get purge -y software-properties-common && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Clone galaxy into /galaxy directory
RUN git clone --depth 1 --single-branch --branch release_17.09_plus_isa_k8s_resource_limts https://github.com/phnmnl/galaxy.git
WORKDIR /galaxy

RUN echo "pykube==0.15.0" >> requirements.txt && \
    echo "-e git://github.com/ISA-tools/isa-rwval.git@develop#egg=isatools" >> requirements.txt

RUN virtualenv .config_script_venv
RUN /bin/bash -c "source .config_script_venv/bin/activate && \
                  pip install bioblend>=0.9.0 && \
                  deactivate"


RUN virtualenv .venv
# We provide --extra-index-url https://pypi.python.org/simple only until the Galaxy people
# update their wheel server to include docutils==0.14, which Galaxy 17.09 requires.

RUN /bin/bash -c "source .venv/bin/activate && \
                  pip install 'pip>=8.1' && \
                  pip install -r requirements.txt \
                      --index-url https://wheels.galaxyproject.org/simple \
                      --extra-index-url https://pypi.python.org/simple && \
                  deactivate && \
                  apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*"


# Galaxy runs on python < 3.5, so https://github.com/kelproject/pykube/issues/29 recommends
ENV PYKUBE_KUBERNETES_SERVICE_HOST kubernetes


##### PhenoMeNal Galaxy Customizations ######
COPY config/datatypes_conf.xml \
     config/galaxy.ini \
     config/job_conf.xml \
     config/job_resource_params_conf.xml \
     config/phenomenal_tools2container.yaml\
     config/sanitize_whitelist.txt \
     config/tool_conf.xml \
  config/

COPY rules/k8s_destinations.py lib/galaxy/jobs/rules/k8s_destination.py
COPY tools/phenomenal tools/phenomenal

# Galaxy tours which guide users through the subsequent steps in an analysis
COPY config/plugins/tours/*.yaml config/plugins/tours/

COPY html/partners.png static/welcome_partners.png
COPY html/PhenoMeNal_logo.png static/welcome_PhenoMeNal_logo.png
COPY html/welcome.html static/

COPY ansible ansible
COPY workflows workflows
COPY container-simple-checks.sh test_cmds.txt ./
RUN chmod u+x /galaxy/ansible/run_galaxy_config.sh

# Missing XCMS datatypes for w4m
COPY external-datatypes/rdata_xcms_datatype.py \
     external-datatypes/rdata_camera_datatype.py \
     external-datatypes/no_unzip_datatypes.py \
     external-datatypes/nmrml_datatype.py \
  /galaxy/lib/galaxy/datatypes/

####################################

EXPOSE 8080

CMD ["./run.sh"]
