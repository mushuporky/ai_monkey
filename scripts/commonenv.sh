#!/bin/bash
###############################################################################
#
#       This script sets common environment variables 
#
###############################################################################
if [ -f /home/ubuntu/xcelerans/projects/ai_monkey/scripts/commonenv.sh ];
then
	# this is the AWS configuration
        export HOMEDIR=/home/ubuntu
else
	# this is the dev env configuration
	export HOMEDIR=/home/kwilloug
fi

export PROJECT_NAME=ai_monkey
export WORKDIR=$HOMEDIR/xcelerans/projects/$PROJECT_NAME
export BINDIR=$WORKDIR/bin

export LOGDIR=$WORKDIR/logs
export DATADIR=$WORKDIR/data
export SCRIPTSDIR=$WORKDIR/scripts
export TMPDIR=$DATADIR/tmp
export HISTORICAL_DATADIR=$DATADIR/historical
export SYMBOL_LIST=$DATADIR/nasdaq/usny_listed.txt
export ENV_ACTIVE_TRADING_DATES_FILE=$DATADIR/active_trading_dates.dat
export AWS_STOCKMONKEY_HOSTNAME=ec2-13-59-75-48.us-east-2.compute.amazonaws.com

export ENV_VAR_DB_NAME=market_wise
export ENV_VAR_DB_USERNAME=xcelerans
export ENV_VAR_DB_PASSWORD=xcelerans
#export ENV_VAR_DB_HOSTNAME=stockmonkey.clelzhvknv31.us-west-1.rds.amazonaws.com
export ENV_VAR_DB_HOSTNAME=xclmktdata.ctqsqn99om4a.us-east-2.rds.amazonaws.com
export ENV_VAR_DB_SSL_CERT=$BINDIR/rds-combined-ca-bundle_stockmonkey_db.pem

export TRUE="TRUE"
export FALSE="FALSE"

