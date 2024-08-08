#!/bin/bash

POSITIONAL_ARGS=()

SCOPE=stacks

while [[ $# -gt 0 ]]; do
  case $1 in
    -e|--environment)
      ENVIRONMENT="$2"
      shift # past argument
      shift # past value
      ;;
    -a|--app)
      SCOPE=apps
      shift # past argument
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

if [[ -n $1 ]]; then
    export STACKS_ENVIRONMENT=${ENVIRONMENT}
    export STACKS_HOME=
    echo "Loading environment from '${ENVIRONMENT}.env'"
    source ./dotenv.sh
    echo "Creating home in '${STACKS_HOME}'"
    find ./apps -maxdepth 1 -name "docker-compose.yml" -exec sh -c 'mkdir -p "${STACKS_HOME}/${0%}"' {} \;
    echo "Running compose for scope '${SCOPE}' and '$1'"
    docker-compose --env-file "${ENVIRONMENT}.env" -f "./$SCOPE/$1/docker-compose.yml" up -d
    exit 0
fi

echo "No scope provided"
exit 0