# Troubleshooting

## apt install <package> Error

### Error sample

```[bash]
root@ed2ff08c7b6b:/# apt install lsb-release
Reading package lists... Done
Building dependency tree
Reading state information... Done
E: Unable to locate package lsb-release
```

### How to fix

1. Check the following file.
```
cat /etc/apt/sources.list
# deb http://snapshot.debian.org/archive/debian/20200130T000000Z stretch main
deb http://deb.debian.org/debian stretch main
# deb http://snapshot.debian.org/archive/debian-security/20200130T000000Z stretch/updates main
deb http://security.debian.org/debian-security stretch/updates main
# deb http://snapshot.debian.org/archive/debian/20200130T000000Z stretch-updates main
deb http://deb.debian.org/debian stretch-updates main
```

2. The contents above is too old to use apt install. So modify like the below.
```
cat /etc/apt/sources.list   
# deb http://snapshot.debian.org/archive/debian/20230227T000000Z bullseye main
deb http://deb.debian.org/debian bullseye main
# deb http://snapshot.debian.org/archive/debian-security/20230227T000000Z bullseye-security main
deb http://deb.debian.org/debian-security bullseye-security main
# deb http://snapshot.debian.org/archive/debian/20230227T000000Z bullseye-updates main
deb http://deb.debian.org/debian bullseye-updates main
```

3. After 2., update apt.
```
root@1c96f5c447a0:/# apt update
Get:1 http://deb.debian.org/debian bullseye InRelease [116 kB]
Get:2 http://deb.debian.org/debian-security bullseye-security InRelease [48.4 kB]
Get:3 http://deb.debian.org/debian bullseye-updates InRelease [44.1 kB]
Get:4 http://deb.debian.org/debian bullseye/main amd64 Packages [8183 kB]
Err:3 http://deb.debian.org/debian bullseye-updates InRelease 
  The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 0E98404D386FA1D9 NO_PUBKEY 6ED0E7B82643E131
Get:5 http://deb.debian.org/debian-security bullseye-security/main amd64 Packages [252 kB]
Reading package lists... Done                       
W: GPG error: http://deb.debian.org/debian bullseye-updates InRelease: The following signatures couldn't be verified because the public key is not available: NO_PUBKEY 0E98404D386FA1D9 NO_PUBKEY 6ED0E7B82643E131
E: The repository 'http://deb.debian.org/debian bullseye-updates InRelease' is not signed.
N: Updating from such a repository can't be done securely, and is therefore disabled by default.
N: See apt-secure(8) manpage for repository creation and user configuration details.
```

4. Finally, you can install packages by apt
```
root@1c96f5c447a0:/# apt install nano
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  gcc-10-base libc-bin libc6 libcom-err2 libcrypt1 libgcc-s1 libgpm2 libgssapi-krb5-2 libidn2-0 libk5crypto3 libkrb5-3 libkrb5support0 libncursesw6 libnsl2 libnss-nis libnss-nisplus libtinfo6
  libtirpc-common libtirpc3 libunistring2

...

Setting up libkrb5-3:amd64 (1.18.3-6+deb11u3) ...
Setting up libgssapi-krb5-2:amd64 (1.18.3-6+deb11u3) ...
Setting up libtirpc3:amd64 (1.3.1-1+deb11u1) ...
Setting up libnsl2:amd64 (1.3.0-2) ...
Setting up libnss-nis:amd64 (3.1-4) ...
Setting up libnss-nisplus:amd64 (1.3-4) ...
Processing triggers for libc-bin (2.31-13+deb11u6) ...
```