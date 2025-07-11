#!/bin/bash

sudo fdisk /dev/sdc << EOF
n
p
1

+10M
n
p
2

+1.5G
t
1
8e
t
2
8e
w
EOF

sudo partprobe

echo
echo "Particiones creadas en /dev/sdc:"
sudo fdisk -l /dev/sdc

# Crea particion swap en /dev/sdd (disco de 1GB)
sudo fdisk /dev/sdd << EOF
n
p
1

+512M
t
1
82
w
EOF

echo
echo "Particiones creadas en /dev/sdd"
sudo fdisk -l /dev/sdd

# Crea volumenes
sudo pvcreate /dev/sdc1 /dev/sdc2

# Crea Volume Group
sudo vgcreate vg_datos /dev/sdc1 /dev/sdc2

# Crea Logical Volumes
sudo lvcreate -L 10M -n lv_docker vg_datos
sudo lvcreate -l +100%FREE -n lv_multimedia vg_datos

# Formateo
sudo mkfs.ext4 /dev/vg_datos/lv_docker
sudo mkfs.ext4 /dev/vg_datos/lv_multimedia

# Creo puntos de montaje
sudo mkdir -p /var/lib/docker
sudo mkdir -p /Multimedia

# Montar
sudo mount /dev/vg_datos/lv_docker /var/lib/docker
sudo mount /dev/vg_datos/lv_multimedia /Multimedia

# Agrego a /etc/fstab
echo '/dev/vg_datos/lv_docker /var/lib/docker ext4 defaults 0 0' | sudo tee -a /etc/fstab
echo '/dev/vg_datos/lv_multimedia /Multimedia ext4 defaults 0 0' | sudo tee -a /etc/fstab

# Activo la memoria swap
sudo mkswap /dev/sdd1
sudo swapon /dev/sdd1
echo '/dev/sdd1 none swap sw 0 0' | sudo tee -a /etc/fstab

# Muestra resultados
echo
echo "Particiones en /dev/sdc:"
sudo fdisk -l /dev/sdc
echo
echo "Particiones en /dev/sdd:"
sudo fdisk -l /dev/sdd
