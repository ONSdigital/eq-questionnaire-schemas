#!/usr/bin/env bash
tag=v3.7.0
TAG=${tag} docker-compose -f docker-compose-schema-validator.yml up -d
