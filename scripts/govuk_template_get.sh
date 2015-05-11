#!/usr/bin/env bash
# Gets govuk_template
# Prepares it to be used with the app

set -e

TMP=$(mktemp -d -t xgs_govuk_template.XXXXXX)
echo "TMP $TMP"
DEST_ZIP=${TMP}/govuk_template.zip
DEST=application/template/govuk_template
mkdir -p $DEST

# Get
curl -L https://github.com/alphagov/govuk_template/archive/master.zip -o $DEST_ZIP
mkdir -p $TMP/unzipped
unzip -q $DEST_ZIP -d $TMP/unzipped

# Prepare
pushd $TMP/unzipped/govuk_template-master
bundle exec rake build:jinja
popd
mv $TMP/unzipped/govuk_template-master/pkg/jinja_govuk_template*/* $DEST

# find application/template/govuk_template -type f -exec md5sum {} \; | md5sum

rm -rf $TMP
