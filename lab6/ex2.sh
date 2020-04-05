#!/bin/bash

# Instalar cups y cups-pdf
sudo apt install cups
sudo apt install cups-pdf

# Cambiamos la carpeta destino 
sudo vim /etc/cups/cups-pdf.conf	

# Damos permisos a cups para que pueda editar la carpeta 
sudo vim /etc/apparmor.d/local/usr.sbin.cupsd

# Creacion de la impresora
sudo lpadmin -p virtualImpre -v cups-pdf:/ -E -P /usr/share/ppd/cups-pdf/CUPS-PDF_opt.ppd

# Configuracion de la impresora
sudo lpoptions -p virtualImpre -o number-up=2 -o sides=two-sided-long-edge -o 
orientation-requested=4

# Para ver las opciones que tenemos configuradas en la impresora
sudo lpoptions -p virtualImpre

Reiniciar el ordenador para que los cambios se hagan efectivos 

# Cuando queremos imprimir
lp -d <impresora> <fitxer>


# Fuentes
# 1. http://www.debianadmin.com/howto-install-and-customize-cups-pdf-in-debian.html
# 2. https://fitzcarraldoblog.wordpress.com/2014/12/06/installing-and-configuring-the-cups-pdf-virtual-printer-driver/
# 3. http://www.debianadmin.com/howto-install-and-customize-cups-pdf-in-debian.html
# 4. https://gist.github.com/aweijnitz/c9ac7a18880225f12bf0
# 5. https://askubuntu.com/questions/509900/generic-cups-pdf-printer-ubuntu-14-04
