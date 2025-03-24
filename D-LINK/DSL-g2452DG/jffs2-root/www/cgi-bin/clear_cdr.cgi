#!/bin/sh
echo "Pragma: no-cache\n"
echo "Cache-control: no-cache\n"
echo "Content-type: text/html"
echo ""

voipcmd cdr clear&
echo "<script>window.location.href='/page/applications/app_voipcdr.shtml';</script>"
