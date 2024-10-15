#!/usr/bin/env bash
tag=`cat .schema-validator-version`
TAG=${tag} docker compose -f docker-compose-schema-validator.yml up -d
