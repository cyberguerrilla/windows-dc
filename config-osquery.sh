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

echo "[OSQUERY] Checking fleetctl status"
while [[ $(sudo docker exec -i fleet /bin/sh -c 'fleetctl login --email guerillaBT@bsides.lab --password bsid3s! 2> /dev/null' | grep -c "Fleet login successful") < 1 ]] ; do
  echo "[OSQUERY] Fleetctl is not up yet"
  sleep 5
done

echo "[OSQUERY] Fleet is up and working, configuring osquery on Windows DC.."

ansible-playbook ./config-osquery.yml
