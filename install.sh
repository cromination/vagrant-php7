sudo apt-get update

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'

sudo apt-get install -y vim curl python-software-properties
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update

sudo apt-get install -y php7.4 php7.4-cli php7.4-common apache2 libapache2-mod-php7 php7.4-curl php7.4-gd php7.4-mcrypt php7.4-readline mysql-server-5.7 php7.4-mysql git-core php7-xdebug

cat << EOF | sudo tee -a /etc/php7.4/mods-available/xdebug.ini
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1
EOF

sudo a2enmod rewrite

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php7.4/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php7.4/apache2/php.ini
sed -i "s/disable_functions = .*/disable_functions = /" /etc/php7.4/cli/php.ini

sudo service apache2 restart

curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
