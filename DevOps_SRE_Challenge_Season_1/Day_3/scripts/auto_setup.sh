#!/usr/bin/env bash

set -e

echo -e "============================ Setup and Install Grafana and Jenkins ====================================\n\n"

echo -e "1. Adding subdomain for grafana nad jenkins\n\n"

# Add subdomain name to the /etc/hosts file 

```bash

cat <<EOF >> /etc/hosts

127.0.0.1 grafana.local
127.0.0.1 jenkins.local

EOF

```

echo -e "================================================\n\n" 