#!/bin/sh
rubocop -a -c .rubocop.yml --force-exclusion `git diff --name-only --staged | grep .rb`