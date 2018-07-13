#!/bin/bash
# vi: fdm=marker

set -e

### Constants ###

SCRIPT_NAME="${0##*/}"
TRUE='true'
FALSE='false'
DFT_DOCKER_PUSH_ENABLED=$TRUE

### Functions ###

function log() {
  echo -e "$@" >&2
}

function error {

	local msg=$1
	local code=$2
	[[ -z $code ]] && code=1

	log "[ERROR] $msg"

	exit $code
}


function debug {

    local msg=$1
    local level=$2
    [[ -n $level ]] || level=1

    [[ $DEBUG -lt $level ]] || log "[DEBUG] $msg"
}

function warning {

    local msg=$1

    log "[WARNING] ##### $msg #####"
}

function print_help {
    (
        echo "Usage: $SCRIPT_NAME [options]"
        echo
        echo "Build PhenoMeNal Galaxy docker images."
        echo
        echo "Options:"
        echo "   -g, --debug                    Debug mode. [false]"
        echo "   -h, --help                     Print this help message."
        echo "   -p, --push                     Push docker images. You can also set environment variable DOCKER_PUSH_ENABLED to \"true\". [true]"
        echo "   +p, --no-push                  Do not push dockers. You can also set environment variable DOCKER_PUSH_ENABLED to \"false\"."
        echo "       --push-intermediate        Also push intermediate images [false]"
        echo "       --no-cache                 Tell Docker not to use cached images. [false]"
        echo "       --init-tag       <tag>     Set the tag for the Galaxy Init Flavour container image."
        echo "       --postgres-tag   <tag>     Set the tag for the Galaxy Postgres container image."
        echo "       --proftpd-tag    <tag>     Set the tag for the Galaxy Proftpd container image."
        echo "       --web-tag        <tag>     Set the tag for the Galaxy Web k8s container image."
        echo "   -u, --container-user <user>    Set the container user. You can also set the environment variable CONTAINER_USER. [pcm32]"
        echo "   -r, --container-registry <reg> Set the container registry. You can also set the environment variable CONTAINER_REGISTRY."
        echo
    ) >&2
}

function read_args {

    local args="$*" # save arguments for debugging purpose

    # Read options
    while [[ $# > 0 ]] ; do
        shift_count=1
        case $1 in
            -g|--debug)              DEBUG=$((DEBUG + 1)) ;;
            -h|--help)               print_help ; exit 0 ;;
            -p|--push)               DOCKER_PUSH_ENABLED=$TRUE ;;
            +p|--no-push)            DOCKER_PUSH_ENABLED=$FALSE ;;
            --push-intermediate)     PUSH_INTERMEDIATE_IMAGES=$TRUE ;;
            --no-cache)              NO_CACHE="--no-cache" ;;
            --postgres-tag)          OVERRIDE_POSTGRES_TAG="$2" ; shift_count=2 ;;
            --proftpd-tag)           OVERRIDE_PROFTPD_TAG="$2" ; shift_count=2 ;;
            --init-tag)              OVERRIDE_GALAXY_INIT_PHENO_FLAVOURED_TAG="$2" ; shift_count=2 ;;
            --web-tag)               OVERRIDE_GALAXY_WEB_K8S_TAG="$2" ; shift_count=2 ;;
            -u|--container-user)     CONTAINER_USER="$2" ; shift_count=2 ;;
            -r|--container-registry) CONTAINER_REGISTRY="$2" ; shift_count=2 ;;
            *) error "Illegal option $1." 98 ;;
        esac
        shift $shift_count
    done

    # Debug messages
    debug "Command line arguments: $args"
    debug "Argument DEBUG=$DEBUG"
    debug "Argument DOCKER_PUSH_ENABLED=$DOCKER_PUSH_ENABLED"
    debug "Argument DOCKER_USER=$DOCKER_USER"
    debug "Argument OVERRIDE_GALAXY_INIT_PHENO_FLAVOURED_TAG=$OVERRIDE_GALAXY_INIT_PHENO_FLAVOURED_TAG"
    debug "Argument OVERRIDE_GALAXY_WEB_K8S_TAG=$OVERRIDE_GALAXY_WEB_K8S_TAG"
    debug "Argument OVERRIDE_POSTGRES_TAG=$OVERRIDE_POSTGRES_TAG"
    debug "Argument OVERRIDE_PROFTPD_TAG=$OVERRIDE_PROFTPD_TAG"
    debug "shift_count=$shift_count"
}

### MAIN ###

read_args "$@"


DOCKER_PUSH_ENABLED=${DOCKER_PUSH_ENABLED:-$DFT_DOCKER_PUSH_ENABLED}

DOCKER_REPO=${CONTAINER_REGISTRY:-}
DOCKER_USER=${CONTAINER_USER:-pcm32}

ANSIBLE_REPO=galaxyproject/ansible-galaxy-extras
ANSIBLE_RELEASE=18.01-k8s

GALAXY_BASE_FROM_TO_REPLACE=quay.io/bgruening/galaxy-base:18.01

GALAXY_REPO=phnmnl/galaxy
GALAXY_RELEASE=release_18.01_plus_isa_runnerRJ_clean

GALAXY_VER_FOR_POSTGRES=18.01

# Default tag.  Note that this is overridden if CONTAINER_TAG_PREFIX and BUILD_NUMBER are set
TAG=v18.01-pheno-dev

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


### Set tags ###
if [[ -n "${OVERRIDE_GALAXY_INIT_PHENO_FLAVOURED_TAG:-}" ]]; then
    GALAXY_INIT_PHENO_FLAVOURED_TAG="${OVERRIDE_GALAXY_INIT_PHENO_FLAVOURED_TAG}"
else
    GALAXY_INIT_PHENO_FLAVOURED_TAG=$DOCKER_REPO$DOCKER_USER/galaxy-init-pheno-flavoured:$TAG
fi

if [[ -n "${OVERRIDE_GALAXY_WEB_K8S_TAG:-}" ]]; then
    GALAXY_WEB_K8S_TAG="${OVERRIDE_GALAXY_WEB_K8S_TAG}"
else
    GALAXY_WEB_K8S_TAG=$DOCKER_REPO$DOCKER_USER/galaxy-web-k8s:$TAG
fi

if [[ -n "${OVERRIDE_POSTGRES_TAG:-}" ]]; then
    POSTGRES_TAG="${OVERRIDE_POSTGRES_TAG}"
else
    PG_Dockerfile="docker-galaxy-stable/compose/galaxy-postgres/Dockerfile"

    [[ -f "${PG_Dockerfile}" ]] || error "The galaxy-postgres Dockerfile is missing under docker-galaxy-stable/.  Have you updated the repository submodules?" 99
    POSTGRES_VERSION=$(grep FROM "${PG_Dockerfile}" | awk -F":" '{ print $2 }')

    POSTGRES_TAG=$DOCKER_REPO$DOCKER_USER/galaxy-postgres:$POSTGRES_VERSION"_for_"$GALAXY_VER_FOR_POSTGRES
fi


if [[ -n "${OVERRIDE_PROFTPD_TAG:-}" ]]; then
    PROFTPD_TAG="${OVERRIDE_PROFTPD_TAG}"
else
    PROFTPD_TAG=$DOCKER_REPO$DOCKER_USER/galaxy-proftpd:for_galaxy_v$GALAXY_VER_FOR_POSTGRES
fi


### do work

if [ -n $ANSIBLE_REPO ]
    then
       log "Making custom galaxy-base-pheno:$TAG from $ANSIBLE_REPO at $ANSIBLE_RELEASE"
       docker build $NO_CACHE --build-arg ANSIBLE_REPO=$ANSIBLE_REPO --build-arg ANSIBLE_RELEASE=$ANSIBLE_RELEASE -t $GALAXY_BASE_PHENO_TAG docker-galaxy-stable/compose/galaxy-base/
       if [[ ! -z ${PUSH_INTERMEDIATE_IMAGES:-} ]];
       then
         log "Pushing intermediate image $DOCKER_REPO$DOCKER_USER/galaxy-base-pheno:$TAG"
           docker push $GALAXY_BASE_PHENO_TAG
       fi
fi


if [ -n $GALAXY_REPO ]
    then
       log "Making custom galaxy-init-pheno:$TAG from $GALAXY_REPO at $GALAXY_RELEASE"
       DOCKERFILE_INIT_1=Dockerfile
       if [ -n $ANSIBLE_REPO ]
       then
           sed s+$GALAXY_BASE_FROM_TO_REPLACE+$GALAXY_BASE_PHENO_TAG+ docker-galaxy-stable/compose/galaxy-init/Dockerfile > docker-galaxy-stable/compose/galaxy-init/Dockerfile_init
           FROM=$(grep ^FROM docker-galaxy-stable/compose/galaxy-init/Dockerfile_init | awk '{ print $2 }')
           log "Using FROM $FROM for galaxy init"
           DOCKERFILE_INIT_1=Dockerfile_init
       fi
       docker build $NO_CACHE --build-arg GALAXY_REPO=$GALAXY_REPO --build-arg GALAXY_RELEASE=$GALAXY_RELEASE --build-arg ISATOOLS_LITE_INSTALL=True -t $GALAXY_INIT_PHENO_TAG -f docker-galaxy-stable/compose/galaxy-init/$DOCKERFILE_INIT_1 docker-galaxy-stable/compose/galaxy-init/
       if [[ ! -z ${PUSH_INTERMEDIATE_IMAGES:-} ]];
       then
           log "Pushing intermediate image $GALAXY_INIT_PHENO_TAG"
           docker push $GALAXY_INIT_PHENO_TAG
       fi
fi


if [ -n $GALAXY_REPO ]
then
  log "Making custom galaxy-init-pheno-flavoured:$TAG starting from galaxy-init-pheno:$TAG"
  sed s+pcm32/galaxy-init-pheno$+$GALAXY_INIT_PHENO_TAG+ $DOCKERFILE_INIT_FLAVOUR > Dockerfile_init_tagged
  DOCKERFILE_INIT_FLAVOUR=Dockerfile_init_tagged
fi
docker build $NO_CACHE -t $GALAXY_INIT_PHENO_FLAVOURED_TAG -f $DOCKERFILE_INIT_FLAVOUR .

if [[ "${DOCKER_PUSH_ENABLED:-}" = "true" ]]; then
  docker push $GALAXY_INIT_PHENO_FLAVOURED_TAG
fi


if [ -n $GALAXY_REPO ]
then
  log "Making custom galaxy-web-k8s:$TAG from $GALAXY_REPO at $GALAXY_RELEASE"
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


log "Relevant containers:"
echo "Web:          $GALAXY_WEB_K8S_TAG"
echo "Init Flavour: $GALAXY_INIT_PHENO_FLAVOURED_TAG"
echo "Postgres:     $POSTGRES_TAG"
echo "Proftpd:      $PROFTPD_TAG"

if [[ "${DOCKER_PUSH_ENABLED:-}" != "true" ]]; then
  log "Container images not pushed.  They are only available in your current Docker daemon"
fi
