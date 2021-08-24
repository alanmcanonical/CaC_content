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

{{% if 'rhel' not in product and 'ubuntu' not in product %}}
{{% set configString = "p+i+n+u+g+s+b+acl+selinux+xattrs+sha512" %}}
{{% else %}}
{{% set configString = "p+i+n+u+g+s+b+acl+xattrs+sha512" %}}
{{% endif %}}

{{% for file in auditfiles %}}
echo "# {{{ file }}} {{{ configString }}}" >> {{{ aide_conf_path }}}
{{% endfor %}}
