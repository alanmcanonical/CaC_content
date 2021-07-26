#!/bin/bash

# Package installation may safely fail if the package is already installed.
{{{ bash_package_install(PKGNAME) -}}} || true
