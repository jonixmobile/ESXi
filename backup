#!/bin/sh

fecha=`date +%H_%d%m%y`
echo $fecha
mkdir -p /vmfs/volumes/62a43d75-c1167f18-0cbd-b8cb29ee39a5/Backups/principal/$fecha
mkdir -p /vmfs/volumes/62a43d75-c1167f18-0cbd-b8cb29ee39a5/Backups/OpenVPN/$fecha

cp /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/principal/principal.vmx \
        /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/principal/principal.nvram \
        /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/principal/principal.vmsd \
        /vmfs/volumes/62a43d75-c1167f18-0cbd-b8cb29ee39a5/Backups/principal/$fecha/

#vmid=$(vim-cmd vmsvc/getallvms | grep web01 | awk '{print $1}')

vim-cmd vmsvc/snapshot.create 59 $fecha 'Snapshot created by Backup Script' 0 0

if [ $RC -ne 0 ]
then
echo  "FALLO"
else
                echo "OK snapshot"
                vmkfstools -i /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/principal/principal.vmdk \
                /vmfs/volumes/62a43d75-c1167f18-0cbd-b8cb29ee39a5/Backups/principal/$fecha/principal.vmdk -d thin
                echo $fecha >> /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/Backups/script/principal.log
                echo "clonado disco de sistema" >> /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/Backups/script/principal.log
                vmkfstools -i /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/principal/datos.vmdk \
                /vmfs/volumes/62a43d75-c1167f18-0cbd-b8cb29ee39a5/Backups/principal/$fecha/datos.vmdk -d thin
                echo $fecha >> /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/Backups/script/principal.log
                echo "clonado disco de datos" >> /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/Backups/script/principal.log

                if [ $RC -ne 0 ]
                then
                echo  "FALLO"
                echo $fecha >> /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/Backups/script/principal.log
                echo "Error al hacer copia de snapshot" >> /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/Backups/script/principal.log

                else
                echo "OK conversion thin"
                        vim-cmd vmsvc/snapshot.removeall 59

                        if [ $RC -ne 0 ]
                        then
                                echo  "Backup Error"
                                echo $fecha >> /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/Backups/script/principal.log
                                echo "Error al borrar snapshot" >> /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/Backups/script/principal.log

                        else
                                echo  "Backup correcto"
                                echo $fecha >> /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/Backups/script/principal.log
                                echo "1" >> /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/Backups/script/principal.log
                                 find /vmfs/volumes/62a43d75-c1167f18-0cbd-b8cb29ee39a5/Backups/principal/ -mtime +17 -exec rm -r  {} \;

                        fi

                fi


fi

cp /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/OpenVPN/OpenVPN.vmx \
        /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/OpenVPN/OpenVPN.nvram \
        /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/OpenVPN/OpenVPN.vmsd \
        /vmfs/volumes/62a43d75-c1167f18-0cbd-b8cb29ee39a5/Backups/OpenVPN/$fecha/

vim-cmd vmsvc/snapshot.create 53 $fecha 'Snapshot created by Backup Script' 0 1

vmkfstools -i /vmfs/volumes/62a3d021-349d6394-1f7d-b8cb29ee39a5/OpenVPN/OpenVPN.vmdk /vmfs/volumes/62a43d75-c1167f18-0cbd-b8cb29ee39a5/Backups/OpenVPN/$fecha/OpenVPN.vmdk -d thin

vim-cmd vmsvc/snapshot.removeall 53
find /vmfs/volumes/62a43d75-c1167f18-0cbd-b8cb29ee39a5/Backups/OpenVPN/ -mtime +17 -exec rm -r  {} \;




