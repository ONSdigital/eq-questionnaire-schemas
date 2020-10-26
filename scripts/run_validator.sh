#!/usr/bin/env bash

tag=add-support-for-first-item-in-list-source
docker pull onsdigital/eq-questionnaire-validator:$tag
docker run -d -p 5001:5000 "onsdigital/eq-questionnaire-validator:$tag"
