#!/bin/bash

{{%- if RECURSIVE %}}
{{% set FIND_RECURSE_ARGS="" %}}
{{%- else %}}
{{% set FIND_RECURSE_ARGS="-maxdepth 1" %}}
{{%- endif %}}

{{%- if EXCLUDED_FILES %}}
{{% set EXCLUDED_FILES_ARGS="! -name '" + EXCLUDED_FILES|join("' ! -name '") + "'" %}}
{{%- else %}}
{{% set EXCLUDED_FILES_ARGS="" %}}
{{%- endif %}}

{{% for path in FILEPATH %}}
{{%- if IS_DIRECTORY %}}
{{%- if FILE_REGEX %}}
find -H {{{ path }}} {{{ FIND_RECURSE_ARGS }}} {{{ EXCLUDED_FILES_ARGS }}} -type f -regex '{{{ FILE_REGEX[loop.index0] }}}' -exec chmod 777 {} \;
{{%- else %}}
find -H {{{ path }}} {{{ FIND_RECURSE_ARGS }}} -type d -exec chmod 777 {} \;
{{%- endif %}}
{{%- else %}}
chmod 777 {{{ path }}}
{{%- endif %}}
{{% endfor %}}
