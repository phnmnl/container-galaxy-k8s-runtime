FROM ubuntu:14.04
MAINTAINER PhenoMeNal-H2020 Project <phenomenal-h2020-users@googlegroups.com>
LABEL Description="Galaxy test for running inside Kubernetes."

RUN apt-get -y update && apt-get install -y git 
RUN git clone https://github.com/phnmnl/galaxy.git
WORKDIR galaxy
RUN git checkout feature/allfeats
RUN echo "-e git+https://github.com/pcm32/pykube.git@feature/allMergedFeatures#egg=pykube" >> requirements.txt
COPY config/galaxy.ini config/galaxy.ini
COPY config/job_conf.xml config/job_conf.xml
COPY config/tool_conf.xml config/tool_conf.xml
COPY other_xml/integrated_tool_panel.xml integrated_tool_panel.xml
COPY tools/. tools/

EXPOSE 8080

CMD ["./run.sh"]
