# 2012-12-16
# Jakub Kułak
# 
# This script is used to deploy hhbdevolution on production server
#
# Usage: 

APP_PATH="/home/hhbd/www/php/app/www.hhbd.pl"

echo "Deployment script for hhbdevolution project (from GitHub)";
if [[ "$1" != "" ]]; then
  #clone read-only repo from github
  git clone git://github.com/jkulak/hhbdevolution.git $APP_PATH/code/tags/v0.$1

  # copy previous .httaccess instead of creating it from example
  cp $APP_PATH/www/public/.htaccess $APP_PATH/code/tags/v0.$1/public/

  # set applcaition/configs/application.ini (database, baseUrl)
  cp $APP_PATH/www/application/configs/application.ini $APP_PATH/code/tags/v0.$1/application/configs/

  # make symbolic link to Zend libraries - no need, because Zend is included in repo
  # ln -s /home/hhbd/www/php/lib/external/Zend /home/hhbd/www/php/app/www.hhbd.pl/svn/www.hhbd.pl/tags/v0.$1/library/Zend

  # make symbolic link to image content
  ln -s $APP_PATH/svn/content/images/ $APP_PATH/code/tags/v0.$1/public/database

  ln -s $APP_PATH/code/tags/v0.$1 $APP_PATH/code/new
  rm $APP_PATH/code/prev
  mv $APP_PATH/code/current $APP_PATH/code/prev
  mv $APP_PATH/code/new $APP_PATH/code/current
  touch $APP_PATH/code/current/.tag-v0.$1

  ls -la $APP_PATH/www
else
  echo "Please specify tag number 0.xx as parameter (ie. ./deploy.sh \"16\")";
fi
