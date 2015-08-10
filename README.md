# GitWeb Pages, on Sandstorm

## About

GitWeb Pages is software that lets you self-host static websites,
where the static website is versioned with git. It requires
[Sandstorm](https://sandstorm.io/).

This source repository contains the code for GitWeb pages, and
instructions on how to modify it for your own needs.

## How to build a Sandstorm package from this repository

* Start from a Linux system running Debian or Ubuntu. If you don't
  have one, create one with Vagrant and then `git clone` this repo
  there. (**Note**: This uses "raw Sandstorm" packaging, not
  `vagrant-spk`. You will need Sandstorm installed on your development
  machine to follow these steps.)

* (HOPEFULLY) Compile the embedded C++ program with:

```
sudo apt-get install libcapnp-dev
cd sandstorm
make
```

* If you find it doesn't compile, then you can nab it out of an
  existing binary package. To do that:

```
cd /tmp
wget http://u0wuqfzjebhnjlva43v1.sandstorm.strange.computer/gitwebpages.spk
spk unpack gitwebpages.spk
cp gitwebpages/sandstorm/bin/getPublicId ~/projects/gitwebpages-sandstorm/sandstorm/bin/
```

* Download dependencies with:

```
sudo apt-get install busybox-static nginx git fcgiwrap
```

* Make sure it runs on your local (development) Sandstorm server with:

```
spk dev
```

* Use Ctrl-C to stop `spk dev`.

* Generate a new "key" (app ID) for your fork of this package with
  by running this command, and then replacing the `id = ...` line in
  `sandstorm-pkgdef.capnp` with the last line.

```
spk keygen
```


* Package it up into a SPK file with:

```
spk pack /tmp/packaged.spk
```

**NOTE**: If you see this message, keep reading.

> hpu0xyfypehsc5k6u0sc98apnk2qh39nys5p1x9gvjtknwahsv60: key not found in keyring

* Test this package by clicking **Upload an app** in your Sandstorm
  server and uploading the package file in `/tmp/packaged.spk`.
