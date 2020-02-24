#!/usr/bin/env bash

branch=remove-hard-coded-census-date
docker pull onsdigital/eq-questionnaire-validator:$branch
docker run -d -p 5001:5000 "onsdigital/eq-questionnaire-validator:$branch"