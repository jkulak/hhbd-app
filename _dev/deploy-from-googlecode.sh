# 2012-12-16
# Jakub Kułak
# 
# This script was used to deploy tags from http://code.google.com/p/hhbdevolution repository
# Code was later (2012-10-11) migrated to GitHub: https://github.com/jkulak/hhbdevolution
#
# To deploy code, please use script: deploy.sh

APP_PATH="/home/hhbd/www/php/app/www.hhbd.pl"

echo "Deploying script for hhbdevolution project.";
if [[ "$1" != "" ]]; then
  #checkout repository from code.google.com
  svn checkout https://hhbdevolution.googlecode.com/svn/tags/v0.$1 $APP_PATH/svn/www.hhbd.pl/tags/v0.$1 --username Jakub.Kulak

  # copy previous .httaccess instead of creating it from example
  # cp $APP_PATH/svn/www.hhbd.pl/tags/v0.$1/public/.htaccess-example $APP_PATH/svn/www.hhbd.pl/tags/v0.$1/public/.htaccess
  cp $APP_PATH/www/public/.htaccess $APP_PATH/svn/www.hhbd.pl/tags/v0.$1/public/

  # set applcaition/configs/application.ini (database, baseUrl)
  cp $APP_PATH/www/application/configs/application.ini $APP_PATH/svn/www.hhbd.pl/tags/v0.$1/application/configs/

  # make symbolic link to Zend libraries
  ln -s /home/hhbd/www/php/lib/external/Zend /home/hhbd/www/php/app/www.hhbd.pl/svn/www.hhbd.pl/tags/v0.$1/library/Zend
  # make symbolic link to image content
  ln -s $APP_PATH/svn/content/images/ $APP_PATH/svn/www.hhbd.pl/tags/v0.$1/public/database

  ln -s $APP_PATH/svn/www.hhbd.pl/tags/v0.$1 $APP_PATH/svn/www.hhbd.pl/new
  rm $APP_PATH/svn/www.hhbd.pl/prev
  mv $APP_PATH/svn/www.hhbd.pl/current $APP_PATH/svn/www.hhbd.pl/prev
  mv $APP_PATH/svn/www.hhbd.pl/new $APP_PATH/svn/www.hhbd.pl/current
  touch $APP_PATH/svn/www.hhbd.pl/current/.tag-v0.$1

  ls -la $APP_PATH/www
else
  echo "Please specify tag number 0.xx as parameter (ie. ./deploy.sh \"16\")";
fi
