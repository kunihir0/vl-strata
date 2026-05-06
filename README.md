<div align="center">

# vl-strata

[![Void Linux](https://img.shields.io/badge/Void_Linux-%23458161.svg?style=flat-square&logo=voidlinux&logoColor=white)](#)
[![License](https://img.shields.io/badge/License-MIT-363a4f.svg?style=flat-square)](#)
[![Build](https://img.shields.io/github/actions/workflow/status/your-user/vl-strata/build.yml?style=flat-square&label=build&color=363a4f)](#)

A minimal, community-driven package overlay for Void Linux.

</div>

---

### 「 overview 」

This repository provides custom package templates designed to be built via `xbps-src`. It functions as an overlay, maintaining an isolated tree that is injected into the official `void-packages` repository at build time.

### 「 packages 」

- `antigravity`

---

### 「 local build 」

To build packages locally, this repository utilizes an injection script. It will clone the official Void repository into an adjacent directory, inject the custom templates, and execute the build.

**1. Clone the repository**
```sh
git clone https://github.com/your-user/vl-strata.git
cd vl-strata
```

**2. Build a package**
```sh
./local-build.sh <package-name>
```
*Note: The built `.xbps` binary will be located in `../void-packages-build/hostdir/binpkgs/`*

---

### 「 usage 」

*Instructions for adding this repository as a remote binary source will be available once the initial CI build has been published.*
