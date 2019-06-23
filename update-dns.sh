#!/bin/bash

echo "[WINDOWS-DC] Looking for Windows DC on the local network"
while [[ $(ip route get 1 | awk '{print $NF;exit}' | sed 's/\.[0-9]*$/.*/' | sudo nmap -sP -iL - -oG - | grep -v Nmap | cut -d " " -f2 | sudo nmap -p 445 --script smb-os-discovery -iL - | grep dc.windomain.local -B 16 | grep "scan report for" | cut -d " " -f5 | tr -d '\n' | wc -l) < 1 ]] ; do
  echo "[WINDOWS-DC] Cannot locate Windows DC"
  sleep 10
done

echo "[WINDOWS-DC] Found Windows DC, running playbook"

ansible-playbook ./config-dns.yml
