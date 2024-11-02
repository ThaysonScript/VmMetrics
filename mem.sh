#!/usr/bin/env bash

VM_USER="root"                # Nome do usuário na VM
VM_IP="10.0.2.17"             # Endereço IP da VM
OUTPUT_FILE="memory.txt"

SSH() {
  ssh-keygen -t rsa -b 2048
  ssh-copy-id "$VM_USER@$VM_IP"
}

: > "$OUTPUT_FILE"

MM() {
  while true; do
      MEMORY_INFO=$(ssh "$VM_USER@$VM_IP" free -m)
  
      TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
  
      echo "$TIMESTAMP - Memória Usada: $MEMORY_INFO MB" >> "$OUTPUT_FILE"
  
      echo "$TIMESTAMP - Memória Usada: $MEMORY_INFO MB"
  
      sleep 3
  done
}

read -p "test ssh connection? [s/n]" sshTest
[[ "$sshTest" == "s" ]] && SSH || MM
