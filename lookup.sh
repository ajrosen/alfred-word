#!/bin/bash

PROTOCOL="https"
HOST="wordsapiv1.p.rapidapi.com"

URL="${PROTOCOL}://${HOST}/words/${*}"
SITE="x-rapidapi-host: ${HOST}"
KEY="x-rapidapi-key: ${API_KEY}"

/usr/bin/curl -s -H "${SITE}" -H "${KEY}" "${URL}"
