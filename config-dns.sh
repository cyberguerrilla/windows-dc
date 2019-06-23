#!/bin/bash

ansible-playbook ./check-prereqs.yml

echo "[WINDOWS-DC] Looking for Windows DC on the local network"
while [[ $(./get-win-ip.sh | wc -w) < 1 ]] ; do
  echo "[WINDOWS-DC] Cannot locate Windows DC"
  sleep 10
done

echo "[WINDOWS-DC] Found Windows DC, running playbook"

ansible-playbook ./config-dns.yml
