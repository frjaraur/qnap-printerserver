#!/bin/bash
set -e
set -x

CUPSPASSWORD="${CUPSPASSWORD:-admin}"

echo print:$CUPSPASSWORD | chpasswd
sed -i 's/CreateSelfSignedCerts/CreateSelfSignedCerts yes/' /etc/cups/cupsd.conf && \
sed -i 's/Listen localhost:631/Listen 0.0.0.0:631/' /etc/cups/cupsd.conf && \
sed -i 's/Browsing Off/Browsing On/' /etc/cups/cupsd.conf && \
sed -i 's/<Location \/>/<Location \/>\n  Allow All/' /etc/cups/cupsd.conf && \
sed -i 's/<Location \/admin>/<Location \/admin>\n  Allow All\n  Require user @SYSTEM/' /etc/cups/cupsd.conf && \
sed -i 's/<Location \/admin\/conf>/<Location \/admin\/conf>\n  Allow All/' /etc/cups/cupsd.conf && \
echo "ServerAlias *" >> /etc/cups/cupsd.conf && \
echo "DefaultEncryption Never" >> /etc/cups/cupsd.conf

[ -f /config/printers.conf ] && cp /config/printers.conf /etc/cups/printers.conf

/usr/sbin/cupsd -t || exit 1 

exec /usr/sbin/cupsd -f
