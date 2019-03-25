#!/bin/bash
composer config -g github-oauth.github.com $DEPT_TOKEN_GITHUB
exec "$@"