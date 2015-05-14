#!/usr/bin/env bash
# Gets govuk_frontend_toolkit
# Prepares it to be used with the app

set -e
ARG=$1

TMP=$(mktemp -d -t xgs_govuk_frontend_toolkit.XXXXXX)
DEST_ZIP=${TMP}/govuk_frontend_toolkit.zip
DEST=application/static/govuk_frontend_toolkit
mkdir -p $DEST

if [ "$ARG" == "clean" ] ; then
  rm -rf $DEST 
elif [ "$ARG" == "get" ] ; then
  # Get
  curl -L https://github.com/alphagov/govuk_frontend_toolkit/archive/master.zip -o $DEST_ZIP
  mkdir -p $TMP/unzipped
  unzip -q $DEST_ZIP -d $TMP/unzipped
  mv $TMP/unzipped/govuk_frontend_toolkit-master/* $DEST
else
  echo "Unknown arg: $ARG"
  exit 1
fi

# find application/static/govuk_frontend_toolkit -type f -exec md5sum {} \; | md5sum

rm -rf $TMP
