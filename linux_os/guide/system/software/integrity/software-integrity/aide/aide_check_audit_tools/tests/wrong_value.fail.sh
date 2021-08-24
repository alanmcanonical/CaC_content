#!/bin/bash

# packages = aide

{{% set auditfiles = [
      "/usr/sbin/auditctl",
      "/usr/sbin/auditd",
      "/usr/sbin/ausearch",
      "/usr/sbin/aureport",
      "/usr/sbin/autrace",
      "/usr/sbin/augenrules" ] %}}

{{% if 'rhel' not in product %}}
{{% set auditfiles = auditfiles + ["/usr/sbin/audispd"] %}}
{{% endif %}}

{{% set configString = "p+i+n+u+g+s+b+acl" %}}

{{% for file in auditfiles %}}
echo "{{{ file }}} {{{ configString }}}" >> {{{ aide_conf_path }}}
{{% endfor %}}
