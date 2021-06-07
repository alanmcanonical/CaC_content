#!/bin/bash
# profiles = xccdf_org.ssgproject.content_profile_cis_level1_server,xccdf_org.ssgproject.content_profile_cis_level1_workstation,xccdf_org.ssgproject.content_profile_cis_level2_server,xccdf_org.ssgproject.content_profile_cis_level2_workstation

username=wichard

sudo deluser ${username}
sudo useradd ${username} -m --password '$6$fcj.zse3x/mbNHiF$pyR/mJuYIAf2LhguL7omzpgNKVqFqo322RBD5gC4k9h2UFSv7HC68iq7FgrAzAhS/aFJX4WvhzXBTobUw.j/w1' -s/bin/bash

for usr in $(egrep ^[^:]+:[^\!*] /etc/shadow | cut -d: -f1); do
    chage --mindays 1 "${usr}"
done
