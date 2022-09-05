#!/usr/bin/env bash
tag=v3.9.0
TAG=${tag} docker-compose -f docker-compose-schema-validator.yml up -d
