#!/bin/bash
set -e

: "${PREFIX:=dev}"

if [[ -z ${AWS_REGION} ]];then
    AWS_REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep -oP '\"region\"[[:space:]]*:[[:space:]]*\"\K[^\"]+')
fi
export AWS_REGION

mkdir -p ~/.aws
cat << EOF > ~/.aws/config
[default]
region = ${AWS_REGION}
EOF

sed -i'' -e 's/PREFIX/'${PREFIX}'/g' /etc/confd/templates/config.php.tmpl

INSTANCE_ID=$(aws ssm get-parameters --query "Parameters[*].Value" --output text --names "/${PREFIX}/nextcloud/instanceid")
if [[ -z ${INSTANCE_ID} ]];then
    echo -n "> Wait for config.php to be written: "
    while [[ ! -f /var/www/html/config/config.php ]];do
        echo -n "."
        sleep 1
    done
    echo "OK"
    echo ">> INSTANCE_ID not set, write parameter store"
    INSTANCE_ID=$(awk '/instanceid/{print $3}' /var/www/html/config/config.php |tr "\'," " ")
    echo "aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/instanceid --value ${INSTANCE_ID}"
    aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/instanceid --value ${INSTANCE_ID}
    NC_PW_SALT=$(awk '/passwordsalt/{print $3}' /var/www/html/config/config.php |tr "\'," " ")
    echo "aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/passwordsalt --value ${NC_PW_SALT}"
    aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/passwordsalt --value ${NC_PW_SALT}
    NC_SECRET=$(awk '/secret/{print $3}' /var/www/html/config/config.php |tr "\'," " ")
    echo "aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/secret --value ${NC_SECRET}"
    aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/secret --value ${NC_SECRET}
    #NC_DOMAIN=$(awk '/overwrite.cli.url/{print $3}' /var/www/html/config/config.php |cut -d/ -f3|tr "\'," " ")
    NC_DOMAIN=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)
    echo "aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/domain --value ${NC_DOMAIN}"
    aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/domain --value ${NC_DOMAIN}
    NC_DB_VERSION=$(awk '/version/{print $3}' /var/www/html/config/config.php |tr "\'," " ")
    echo "aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/database/version --value ${NC_DB_VERSION}"
    aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/database/version --value ${NC_DB_VERSION}
    NC_DB_NAME=$(awk '/dbhost/{print $3}' /var/www/html/config/config.php |cut -d\. -f1 |tr "\'," " ")
    echo "aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/database/name --value ${NC_DB_NAME}"
    aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/database/name --value ${NC_DB_NAME}
    NC_DB_CLUSTER=$(awk '/dbhost/{print $3}' /var/www/html/config/config.php |cut -d\. -f2 |tr "\'," " ")
    echo "aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/database/cluster --value ${NC_DB_CLUSTER}"
    aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/database/cluster --value ${NC_DB_CLUSTER}
    NC_DB_REGION=$(awk '/dbhost/{print $3}' /var/www/html/config/config.php |cut -d\. -f3 |tr "\'," " ")
    echo "aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/database/region --value ${NC_DB_REGION}"
    aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/database/region --value ${NC_DB_REGION}
    NC_DB_USER=$(awk '/dbuser/{print $3}' /var/www/html/config/config.php |tr "\'," " ")
    echo "aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/database/user --value ${NC_DB_USER}"
    aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/database/user --value ${NC_DB_USER}
    NC_DB_PASSWD=$(awk '/dbpassword/{print $3}' /var/www/html/config/config.php |tr "\'," " ")
    echo "aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/database/password --value ${NC_DB_PASSWD}"
    aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/database/password --value ${NC_DB_PASSWD}
else
    echo ">> parameter store already filled"
fi
NC_DOMAIN=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)
echo "aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/domain --value ${NC_DOMAIN}"
aws ssm put-parameter --type String --name /${PREFIX}/nextcloud/domain --value ${NC_DOMAIN} --overwrite
echo "> confd -onetime -backend ssm"
confd -onetime -backend ssm