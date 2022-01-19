#!/usr/bin/env bash
tag=v3.2.0
TAG=${tag} docker-compose -f docker-compose-schema-validator.yml up -d
