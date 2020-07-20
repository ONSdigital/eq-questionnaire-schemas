#!/bin/bash

for file in $(find ./source -name '*.jsonnet'); do
  jsonnetfmt -i $file
done