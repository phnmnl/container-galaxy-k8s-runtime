#!/bin/bash

set -e

#################
### Behaviour ###
DOCKER_PUSH_ENABLED=${DOCKER_PUSH_ENABLED:-true}

# Uncomment to avoid using the cache when building docker images.
#NO_CACHE="--no-cache"

# Uncomment to push intermediate images, otherwise only the images needed for the helm chart are pushed.
#PUSH_INTERMEDIATE_IMAGES=yes


#######################
### tags and images ###
DOCKER_REPO=${CONTAINER_REGISTRY:-}
DOCKER_USER=${CONTAINER_USER:-pcm32}

ANSIBLE_REPO=galaxyproject/ansible-galaxy-extras
ANSIBLE_RELEASE=18.01-k8s

GALAXY_BASE_FROM_TO_REPLACE=quay.io/bgruening/galaxy-base:18.01

GALAXY_REPO=phnmnl/galaxy
GALAXY_RELEASE=release_18.01_plus_isa_runnerRestartJobs

GALAXY_VER_FOR_POSTGRES=18.01

# Default tag.  Note that this is overridden if CONTAINER_TAG_PREFIX and BUILD_NUMBER are set
TAG=v18.01-pheno-dev

#######################
if [[ -n ${CONTAINER_TAG_PREFIX:-} && -n ${BUILD_NUMBER:-} ]]; then
    TAG=${CONTAINER_TAG_PREFIX}.${BUILD_NUMBER}
fi

DOCKERFILE_INIT_FLAVOUR=Dockerfile_init
DOCKERFILE_WEB=Dockerfile

if [[ -n "${DOCKER_REPO}" ]]; then
    # Append slash, avoiding double slash
    DOCKER_REPO="${DOCKER_REPO%/}/"
fi

GALAXY_BASE_PHENO_TAG=$DOCKER_REPO$DOCKER_USER/galaxy-base-pheno:$TAG
GALAXY_INIT_PHENO_TAG=$DOCKER_REPO$DOCKER_USER/galaxy-init-pheno:$TAG
GALAXY_INIT_PHENO_FLAVOURED_TAG=$DOCKER_REPO$DOCKER_USER/galaxy-init-pheno-flavoured:$TAG
GALAXY_WEB_K8S_TAG=$DOCKER_REPO$DOCKER_USER/galaxy-web-k8s:$TAG

PG_Dockerfile="docker-galaxy-stable/compose/galaxy-postgres/Dockerfile"
if [[ ! -f "${PG_Dockerfile}" ]]; then
  echo "Error!  The galaxy-postgres Dockerfile is missing under docker-galaxy-stable/.  Have you updated the repository submodules?" >&2
  exit 99
fi
POSTGRES_VERSION=$(grep FROM "${PG_Dockerfile}" | awk -F":" '{ print $2 }')

POSTGRES_TAG=$DOCKER_REPO$DOCKER_USER/galaxy-postgres:$POSTGRES_VERSION"_for_"$GALAXY_VER_FOR_POSTGRES
PROFTPD_TAG=$DOCKER_REPO$DOCKER_USER/galaxy-proftpd:for_galaxy_v$GALAXY_VER_FOR_POSTGRES


############## Main #######################

if [ -n $ANSIBLE_REPO ]
    then
       echo "Making custom galaxy-base-pheno:$TAG from $ANSIBLE_REPO at $ANSIBLE_RELEASE"
       docker build $NO_CACHE --build-arg ANSIBLE_REPO=$ANSIBLE_REPO --build-arg ANSIBLE_RELEASE=$ANSIBLE_RELEASE -t $GALAXY_BASE_PHENO_TAG docker-galaxy-stable/compose/galaxy-base/
       if [[ ! -z ${PUSH_INTERMEDIATE_IMAGES:-} ]];
       then
         echo "Pushing intermediate image $DOCKER_REPO$DOCKER_USER/galaxy-base-pheno:$TAG"
           docker push $GALAXY_BASE_PHENO_TAG
       fi
fi


if [ -n $GALAXY_REPO ]
    then
       echo "Making custom galaxy-init-pheno:$TAG from $GALAXY_REPO at $GALAXY_RELEASE"
       DOCKERFILE_INIT_1=Dockerfile
       if [ -n $ANSIBLE_REPO ]
       then
           sed s+$GALAXY_BASE_FROM_TO_REPLACE+$GALAXY_BASE_PHENO_TAG+ docker-galaxy-stable/compose/galaxy-init/Dockerfile > docker-galaxy-stable/compose/galaxy-init/Dockerfile_init
           FROM=$(grep ^FROM docker-galaxy-stable/compose/galaxy-init/Dockerfile_init | awk '{ print $2 }')
           echo "Using FROM $FROM for galaxy init"
           DOCKERFILE_INIT_1=Dockerfile_init
       fi
       docker build $NO_CACHE --build-arg GALAXY_REPO=$GALAXY_REPO --build-arg GALAXY_RELEASE=$GALAXY_RELEASE --build-arg ISATOOLS_LITE_INSTALL=True -t $GALAXY_INIT_PHENO_TAG -f docker-galaxy-stable/compose/galaxy-init/$DOCKERFILE_INIT_1 docker-galaxy-stable/compose/galaxy-init/
       if [[ ! -z ${PUSH_INTERMEDIATE_IMAGES:-} ]];
       then
           echo "Pushing intermediate image $GALAXY_INIT_PHENO_TAG"
           docker push $GALAXY_INIT_PHENO_TAG
       fi
fi


if [ -n $GALAXY_REPO ]
then
  echo "Making custom galaxy-init-pheno-flavoured:$TAG starting from galaxy-init-pheno:$TAG"
  sed s+pcm32/galaxy-init-pheno$+$GALAXY_INIT_PHENO_TAG+ $DOCKERFILE_INIT_FLAVOUR > Dockerfile_init_tagged
  DOCKERFILE_INIT_FLAVOUR=Dockerfile_init_tagged
fi
docker build $NO_CACHE -t $GALAXY_INIT_PHENO_FLAVOURED_TAG -f $DOCKERFILE_INIT_FLAVOUR .

if [[ "${DOCKER_PUSH_ENABLED:-}" = "true" ]]; then
  docker push $GALAXY_INIT_PHENO_FLAVOURED_TAG
fi


if [ -n $GALAXY_REPO ]
then
  echo "Making custom galaxy-web-k8s:$TAG from $GALAXY_REPO at $GALAXY_RELEASE"
  sed s+$GALAXY_BASE_FROM_TO_REPLACE+$GALAXY_BASE_PHENO_TAG+ docker-galaxy-stable/compose/galaxy-web/Dockerfile > docker-galaxy-stable/compose/galaxy-web/Dockerfile_web
  DOCKERFILE_WEB=Dockerfile_web
fi
docker build $NO_CACHE --build-arg GALAXY_ANSIBLE_TAGS=supervisor,startup,scripts,nginx,k8,k8s -t $GALAXY_WEB_K8S_TAG -f docker-galaxy-stable/compose/galaxy-web/$DOCKERFILE_WEB docker-galaxy-stable/compose/galaxy-web/

if [[ "${DOCKER_PUSH_ENABLED:-}" = "true" ]]; then
  docker push $GALAXY_WEB_K8S_TAG
fi

# Build postgres
docker build -t $POSTGRES_TAG -f docker-galaxy-stable/compose/galaxy-postgres/Dockerfile docker-galaxy-stable/compose/galaxy-postgres/

if [[ "${DOCKER_PUSH_ENABLED:-}" = "true" ]]; then
  docker push $POSTGRES_TAG
fi

# Build proftpd
docker build -t $PROFTPD_TAG -f docker-galaxy-stable/compose/galaxy-proftpd/Dockerfile docker-galaxy-stable/compose/galaxy-proftpd/

if [[ "${DOCKER_PUSH_ENABLED:-}" = "true" ]]; then
  docker push $PROFTPD_TAG
fi


echo "Relevant containers:"
echo "Web:          $GALAXY_WEB_K8S_TAG"
echo "Init Flavour: $GALAXY_INIT_PHENO_FLAVOURED_TAG"
echo "Postgres:     $POSTGRES_TAG"
echo "Proftpd:      $PROFTPD_TAG"

if [[ "${DOCKER_PUSH_ENABLED:-}" = "true" ]]; then
  echo "Containers not pushed.  They are only available in your current Docker daemon"
fi
