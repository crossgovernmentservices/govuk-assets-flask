#!/usr/bin/env bash

set -e

TOOLKIT=application/static/govuk_frontend_toolkit

if [ ! -e .git ]; then
  echo "Git submodule can't be added - no .git found"
  exit 1
fi

if [ -e $TOOLKIT ] ; then
  pushd $TOOLKIT
  git pull
  popd
else
  git submodule add -f https://github.com/alphagov/govuk_frontend_toolkit.git   application/static/govuk_frontend_toolkit
fi
