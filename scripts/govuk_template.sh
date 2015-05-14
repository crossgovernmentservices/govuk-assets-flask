#!/usr/bin/env bash
# Gets govuk_template
# Prepares it to be used with the app

set -e
ARG=$1

TMP=$(mktemp -d -t xgs_govuk_template.XXXXXX)
DEST_ZIP=${TMP}/govuk_template.zip
DEST_VIEWS=application/templates/govuk_template
DEST_ASSETS=application/static/govuk_template

if [ "$ARG" == "clean" ] ; then
  rm -rf $DEST_ASSETS
  rm -rf $DEST_VIEWS
elif [ "$ARG" == "get" ] ; then
  # Get
  curl -L https://github.com/alphagov/govuk_template/archive/master.zip -o $DEST_ZIP
  mkdir -p $TMP/unzipped
  unzip -q $DEST_ZIP -d $TMP/unzipped

  # Prepare
  pushd $TMP/unzipped/govuk_template-master
  bundle install
  bundle exec rake build:jinja
  popd
  mkdir -p $DEST_VIEWS
  mkdir -p $DEST_ASSETS
  mv $TMP/unzipped/govuk_template-master/pkg/jinja_govuk_template*/assets $DEST_ASSETS
  mv $TMP/unzipped/govuk_template-master/pkg/jinja_govuk_template*/views $DEST_VIEWS
else
  echo "Unknown arg: $ARG"
  exit 1
fi

# find application/templates/govuk_template -type f -exec md5sum {} \; | md5sum
# find application/static/govuk_template -type f -exec md5sum {} \; | md5sum

rm -rf $TMP
