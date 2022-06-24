#!/bin/bash

aws ecr put-registry-scanning-configuration \
    --scan-type BASIC \
    --rules 'scanFrequency=SCAN_ON_PUSH,repositoryFilters=[{filter=ub-*,filterType=WILDCARD}]'
