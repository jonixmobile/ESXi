#!/bin/bash
echo "apagandoFIN" >> /var/log/test.txt

sshpass -p "R"  ssh -o StrictHostKeyChecking=no root@192.168.1.x '/bin/sh /vmfs/volumes/667fb2fd-5cc24f99-8a1d-000c2917b4b2/ISO/shutdown.sh'

swaks --from backup@mail.com --to jonixmobile@gmail.com --server smtp.serviciodecorreo.es:587 --auth PLAIN --tls --auth-user "backup@mail.com" --auth-password "G" --header "Subject: Test APAGANDO SERVIDOR" --body "Se apaga servidor."
