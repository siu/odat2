#!/bin/bash
patch vendor/plugins/restful_authentication/lib/authorization/stateful_roles.rb install/patches/no_activation.diff
patch vendor/plugins/prawnto/lib/prawnto/template_handler/compile_support.rb install/patches/prawnto-fix_https.diff
