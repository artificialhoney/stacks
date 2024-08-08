#!/bin/bash

POSITIONAL_ARGS=()

STACKS_SCOPE=stacks

while [[ $# -gt 0 ]]; do
  case $1 in
    -e|--environment)
      STACKS_ENVIRONMENT="$2"
      shift # past argument
      shift # past value
      ;;
    -a|--app+)
      STACKS_SCOPE=apps
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
    export STACKS_ENVIRONMENT=${STACKS_ENVIRONMENT:-"local"}
    echo "Loading environment from '${STACKS_ENVIRONMENT}.env'"
    [ -f $STACKS_ENVIRONMENT.env ] && export $(grep -v '^#' $STACKS_ENVIRONMENT.env | xargs)
    echo "Creating home in '${STACKS_HOME}'"
    find ./apps -maxdepth 1 -execdir sh -c 'mkdir -p "../${STACKS_HOME}/${0%}"' {} \;
    echo "Running compose in '${STACKS_SCOPE}' with '${@}'"
    for arg in "${@}"
    do
      docker-compose --env-file "${STACKS_ENVIRONMENT}.env" -f "./$STACKS_SCOPE/$arg/docker-compose.yml" up -d
    done

    exit 0
fi

echo "No scope provided"
exit 0