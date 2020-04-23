#!/usr/bin/env bash

branch=remove-section-summary-block-add-section-end-routing
docker pull onsdigital/eq-questionnaire-validator:$branch
docker run -d -p 5001:5000 "onsdigital/eq-questionnaire-validator:$branch"
