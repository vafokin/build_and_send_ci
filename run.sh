#!/bin/bash

PIPELINE=$(curl -k --request POST --header "PRIVATE-TOKEN: 'TOKEN'" --form "ref=main" --form "variables[][key]=PORT" --form "variables[][variable_type]=env_var" --form "variables[][value]=${PORT_NGINX}" --form "variables[][key]=BUILD_DJANGO" --form "variables[][variable_type]=env_var" --form "variables[][value]=${IMAGE_DJANGO}"  --form "variables[][key]=BUILD_NGINX" --form "variables[][variable_type]=env_var" --form "variables[][value]=${IMAGE_NGINX}" --form "variables[][key]=REGISTRY" --form "variables[][variable_type]=env_var" --form "variables[][value]=${CI_REGISTRY}" --form "variables[][key]=BRANCH" --form "variables[][variable_type]=env_var" --form "variables[][value]=${NAME_STAGE}" "https://gitlab.com/api/v4/projects/37585669/pipeline" | jq '[.[]][0]')

JOB=$(curl -k --header "PRIVATE-TOKEN: 'TOKEN'" "https://gitlab.com/api/v4/projects/37585669/pipelines/$PIPELINE/jobs" | jq '.[] | [.id][0]')

curl -k --request POST --header "PRIVATE-TOKEN: 'TOKEN'" "https://gitlab.com/api/v4/projects/37585669/jobs/$JOB/play"
