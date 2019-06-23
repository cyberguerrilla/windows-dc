#!/bin/bash

echo "[WINDOWS-DC] Looking for Windows DC on the local network"
while [[ $(ip route get 1 | awk '{print $NF;exit}' | sed 's/\.[0-9]*$/.*/' | sudo nmap -sP -iL - -oG - | grep -v Nmap | cut -d " " -f2 | sudo nmap -p 445 --script smb-os-discovery -iL - | grep dc.windomain.local -B 16 | grep "scan report for" | cut -d " " -f5 | tr -d '\n' | wc -l) < 1 ]] ; do
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
