#!/bin/bash
# profiles = xccdf_org.ssgproject.content_profile_ncp

# we don't use packages statement here since Ubuntu uses different packages from other distros.

source $SHARED/dconf_test_functions.sh

install_dconf_and_gdm_if_needed

clean_dconf_settings

