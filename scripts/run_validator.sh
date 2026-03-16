#!/usr/bin/env bash
tag="eqs-730-add-validator-version-and-success"
TAG=${tag} docker compose -f docker-compose-schema-validator.yml up -d
