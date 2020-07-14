#!/bin/bash

for file in $(find ./source -name '*.jsonnet' -o -name '*.libsonnet'); do
  jsonnetfmt -i $file
done