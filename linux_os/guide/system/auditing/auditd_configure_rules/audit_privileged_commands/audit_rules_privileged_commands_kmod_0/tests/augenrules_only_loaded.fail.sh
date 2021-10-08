#!/bin/bash

# packages = {{{ ssgts_package("audit") }}}

auditctl -w /bin/kmod -p x -k modules
