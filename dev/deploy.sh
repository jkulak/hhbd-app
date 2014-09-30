#!/usr/bin/env bash

# 2012-12-16
# Jakub Kułak
#
# This script is used to deploy hhbdevolution on production server
#
# Usage: $ ./deploy.sh "new-feature-added"

APP_PATH="/home/hhbd/www/vhosts/www.hhbd.pl"
DATE=$(date +%F)

echo "Deploying hhbd.pl"
echo "---> to: $APP_PATH";

if [[ "$1" != "" ]]; then

  TAG_NAME=$DATE-$1

  #clone read-only repo from github
  git clone git://github.com/jkulak/hhbd.git $APP_PATH/code/tags/$TAG_NAME

  # copy previous .httaccess instead of creating it from example
  cp $APP_PATH/www/public/.htaccess $APP_PATH/code/tags/$TAG_NAME/www/hhbd.pl/public/

  # copy previous application.ini (database, baseUrl)
  cp $APP_PATH/www/application/configs/application.ini $APP_PATH/code/tags/$TAG_NAME/www/hhbd.pl/application/configs/

  # make symbolic link to image content
  ln -s $APP_PATH/svn/content/images/ $APP_PATH/code/tags/$TAG_NAME/www/hhbd.pl/public/database

  ln -s $APP_PATH/code/tags/$TAG_NAME/www/hhbd.pl $APP_PATH/code/new
  rm $APP_PATH/code/prev
  mv $APP_PATH/code/current $APP_PATH/code/prev
  mv $APP_PATH/code/new $APP_PATH/code/current
  touch $APP_PATH/code/current/.tag-$TAG_NAME

  ls -la $APP_PATH/www
else
  echo "Please give this release a name (ie. ./deploy.sh \"Add-voting\")";
fi
