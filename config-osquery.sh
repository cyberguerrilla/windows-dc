#!/bin/bash

echo "[WINDOWS-DC] Looking for Windows DC on the local network"
while [[ $(./get-win-ip.sh | wc -w) < 1 ]] ; do
  echo "[WINDOWS-DC] Cannot locate Windows DC"
  sleep 10
done

echo "[OSQUERY] Checking if Kolide container is running"
while [[ $(docker ps -q -f name=fleet -f status=running | wc -l) < 1 ]] ; do
  echo "[OSQUERY] Kolide container is not running"
  sleep 10
done

echo "[OSQUERY] Found Kolide container running script to update osquery agent"

ansible-playbook ./config-osquery.yml
