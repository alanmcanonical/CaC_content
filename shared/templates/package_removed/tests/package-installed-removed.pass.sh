#!/bin/bash

# Package installation may safely fail if package is already installed.
{{{ bash_package_install(PKGNAME) -}}} || true
{{{ bash_package_remove(PKGNAME) }}}
