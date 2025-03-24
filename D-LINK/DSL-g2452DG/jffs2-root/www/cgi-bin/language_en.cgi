#!/bin/sh

echo -en "Pragma: no-cache\r\n"
echo -en "Cache-control: no-cache\r\n"
echo -en "Content-type: text/html\r\n"
echo -en "\r\n"

echo -n "<script>window.setTimeout(\"location.href='/index.html'\");</script>"
