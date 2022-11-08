#!/usr/bin/env bash
tag=v3.10.0
TAG=${tag} docker-compose -f docker-compose-schema-validator.yml up -d
