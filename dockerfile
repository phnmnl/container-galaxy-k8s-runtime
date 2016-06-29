FROM ubuntu:14.04

RUN git clone https://github.com/phnmnl/galaxy.git
WORKDIR galaxy
RUN git checkout feature/allfeats
RUN cat "-e git+https://github.com/pcm32/pykube.git@feature/allMergedFeatures#egg=pykube" >> dependencies/pinned-requirements.txt
RUN ln -s requirements.txt dependencies/pinned-requirements.txt

