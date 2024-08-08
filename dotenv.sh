#!/bin/bash

# source deploy.sh

[ -f $STACKS_ENVIRONMENT.env ] && export $(grep -v '^#' $STACKS_ENVIRONMENT.env | xargs)