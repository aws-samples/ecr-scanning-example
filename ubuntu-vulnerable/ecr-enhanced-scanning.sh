#!/bin/bash

aws ecr put-registry-scanning-configuration \
    --scan-type ENHANCED \
    --rules '[{"scanFrequency": "SCAN_ON_PUSH","repositoryFilters": [{"filter": "ub-*","filterType": "WILDCARD"}]},{"scanFrequency": "CONTINUOUS_SCAN","repositoryFilters": [{"filter": "ub-*","filterType": "WILDCARD"}]}]'
