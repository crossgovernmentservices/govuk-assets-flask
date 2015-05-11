#!/usr/bin/env bash
# Gets govuk_elements
# Prepares it to be used with the app

set -e

TMP=$(mktemp -d -t xgs_govuk_elements.XXXXXX)
DEST_ZIP=${TMP}/govuk_elements.zip
DEST=application/static/govuk_elements
mkdir -p $DEST

# Get
curl -L https://github.com/alphagov/govuk_elements/archive/master.zip -o $DEST_ZIP
mkdir -p $TMP/unzipped
unzip -q $DEST_ZIP -d $TMP/unzipped
mv $TMP/unzipped/govuk_elements-master/* $DEST

# Prepare
for sassfile in $(find $DEST -name '*.scss'); do
  sed -i '/^@import .*/d' $sassfile
done

# find application/static/govuk_elements -type f -exec md5sum {} \; | md5sum

rm -rf $TMP
