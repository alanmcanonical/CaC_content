documentation_complete: true

title: 'CIS Ubuntu 20.04 Level 1 OpenStack Server Benchmark'

description: |-
    This baseline aligns to the Center for Internet Security
    Ubuntu 20.04 LTS Benchmark, v1.0.0, released 07-21-2020.
    It includes changes to improve OpenStack compatibility.

extends: cis_level1_server

selections:
    ### 2.2.16 Ensure rsync service is not installed (Automated)
    # rsync is required for OpenStack to function.
    - '!package_rsync_removed'

    # OpenStack depends on UFW as the default firewall front-end.
    - var_firewall_package=ufw
