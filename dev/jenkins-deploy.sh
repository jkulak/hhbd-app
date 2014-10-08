#!/usr/bin/env bash

# 2014-10-08
# Jakub Kułak
#
# This script is used to deploy hhbd to beta.hhbd.pl using Jenkins

APP_PATH="/home/hhbd/www/vhosts/beta.hhbd.pl"
DATE=$(date +%F)

echo "Deploying hhbd.pl"

TAG_NAME=$DATE-$BUILD_TAG

# copy app code
cp -rf www/hhbd.pl $APP_PATH/code/tags/$TAG_NAME

# copy previous .httaccess instead of creating it from example
cp $APP_PATH/public/.htaccess $APP_PATH/code/tags/$TAG_NAME/public/

# copy previous application.ini (database, baseUrl)
cp $APP_PATH/application/configs/application.ini $APP_PATH/code/tags/$TAG_NAME/www/hhbd.pl/application/configs/

# create temporary new code link
ln -s $APP_PATH/code/tags/$TAG_NAME $APP_PATH/code/new

# Remove previous prev link, we keep it after build for quick switch to previous version in case of problems
rm $APP_PATH/code/prev

# Rename current link to prev link - app stops working here for a millisecond
mv $APP_PATH/code/current $APP_PATH/code/prev

# Rename newest tag to current - app starts working here again
mv $APP_PATH/code/new $APP_PATH/code/current

# Mark current with tag name
touch $APP_PATH/code/current/.tag-$TAG_NAME
