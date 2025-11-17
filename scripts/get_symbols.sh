#!/bin/bash

###############################################################################
#
#    This is the script to curl the latest symbols from nasdaqtrader.com
#
###############################################################################

echo ' ' 
echo '***************************************************************************'
echo '     updating symbol list                                                  ' 
echo '***************************************************************************'
echo ' '  

# get the common environment
if [ -z ${WORKDIR} ];
then
        source $PWD/commonenv.sh
fi

DATE=_"$(date '+%m%d%y')"
FILESDIR=$DATADIR/nasdaq
FILE1=nasdaqlisted.txt
FILE2=otherlisted.txt
FILE3=usny_listed.txt
FILENAME1=$FILESDIR/$FILE1$DATE.txt
FILENAME2=$FILESDIR/$FILE2$DATE.txt
CURLURL1=https://www.nasdaqtrader.com/dynamic/SymDir/nasdaqlisted.txt
CURLURL2=https://www.nasdaqtrader.com/dynamic/SymDir/otherlisted.txt

#echo retrieving files $FILENAME1 $FILENAME2

# get the symbol files
echo opening $CURLURL1
curl $CURLURL1 > $FILENAME1

echo 
echo opening $CURLURL2
curl $CURLURL2 > $FILENAME2
echo 

# replace existing files if retrieval is successful
if [ -s $FILENAME1 ]
then
    rm $FILESDIR/$FILE1
    mv $FILENAME1 $FILESDIR/$FILE1
fi


if [ -s $FILENAME2 ]
then
    rm $FILESDIR/$FILE2
    mv $FILENAME2 $FILESDIR/$FILE2
fi

#clean up the symbols
./prune_symbols.sh

echo 'done'

