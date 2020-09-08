#!/usr/bin/env bash

tag=resolve-schemas-suggestions-urls
docker pull onsdigital/eq-questionnaire-validator:$tag
docker run -d -p 5001:5000 "onsdigital/eq-questionnaire-validator:$tag"
