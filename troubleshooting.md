Sometimes packages may be missing in upstream repos. Here's a simple way to repro for a support case:

```
$ docker run -it debian:buster bash
# inside the debian shell
root@d88e4880deb4:/# apt update && apt install wget gnupg -y
root@d88e4880deb4:/# wget http://apt.cumulusnetworks.com/repo/pool/cumulus/c/cumulus-archive-keyring/cumulus-archive-keyring_4-cl5.0.0u7_all.deb
root@d88e4880deb4:/# dpkg -i cumulus-archive-keyring_4-cl5.0.0u7_all.deb
root@d88e4880deb4:/# tee /etc/apt/sources.list << EOF
deb      http://apt.cumulusnetworks.com/repo CumulusLinux-5-latest cumulus upstream netq
deb-src  http://apt.cumulusnetworks.com/repo CumulusLinux-5-latest cumulus upstream netq
EOF
root@d88e4880deb4:/# apt update
# some packages can be installed
root@d88e4880deb4:/# apt install mstpd -y
# while others cannot 
root@d88e4880deb4:/# apt install cumulus-libs 
Reading package lists... Done
Building dependency tree
Reading state information... Done
Package cumulus-libs is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or
is only available from another source
```