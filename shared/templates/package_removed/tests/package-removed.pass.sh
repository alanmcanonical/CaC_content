#!/bin/bash

# Package remove may safely fail if the package is already removed.
{{{ bash_package_remove(PKGNAME) -}}} || true
