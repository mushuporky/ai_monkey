#!/bin/bash
echo ' ' 
echo '*************************************************************************** '
echo '     pruning symbol list                                                    '
echo '*************************************************************************** '
echo ' ' 

source $PWD/commonenv.sh

# for each file to be processed,
# parse out preferred stocks - noted with a '$' character in the symbol
# parse out test stocks - identified with "NASDAQ TEST STOCK" in the description field
FILESDIR=$DATADIR/nasdaq
FILE1=nasdaqlisted.txt
FILE2=otherlisted.txt
FILE3=usny_listed.txt
INFILE1=$FILESDIR/$FILE1
INFILE2=$FILESDIR/$FILE2
OUTFILE=$FILESDIR/$FILE3
INPUTFILES=($INFILE1 $INFILE2)
let NUMSYMSWRITTEN=0

# save default tokens
OIFS="$IFS"

# delete outfile 
if [ -e $OUTFILE ]
then
    rm $OUTFILE  
fi

##########################################################
# do all of the things 
##########################################################
# process all of the input files
for i in "${INPUTFILES[@]}"
do

    # if file exists, process it 
    if [ -e $i ]
    then
        echo "Parsing file $i"

        let CURRENTLINE=0
        let LASTLINENUM=$(<$i wc -l)
        #echo "LASTLINENUM = $LASTLINENUM"

        while read line
        do
            
            IFS="|"
            read -a LINE_ITEMS <<< "${line}"
            (( CURRENTLINE+=1 ))

            if [[ $CURRENTLINE -eq 1 ]]
            then
                #echo "skipping first line"
                continue
            fi

            if [[ $(( $CURRENTLINE+0 )) -eq $(( $LASTLINENUM+0 )) ]]
            then
                #echo "skipping last line"
                continue
            fi

            # skip preferred stocks 
            SYMBOL=${LINE_ITEMS[0]}
            if [[ $SYMBOL == *"$"* ]]; then
                #echo "Skipping symbol $SYMBOL"
                continue
            fi

            # skip nasdaq test stocks
            NAME=${LINE_ITEMS[1]}
            if [[ $NAME == *"NASDAQ TEST STOCK"* ]]; then
                #echo "Skipping test stock $SYMBOL"
                continue
            fi
            
            # append to output file
            IFS="$OIFS"
            OUTLINE="$SYMBOL|$NAME"
            echo $OUTLINE >> $OUTFILE
            (( NUMSYMSWRITTEN+=1 ))

        done < $i

        #echo "CURRENTLINE = $CURRENTLINE"

    else
        echo "File not found: $1"
    fi

done

echo "wrote $NUMSYMSWRITTEN symbols to file $OUTFILE"
echo " "

# restore tokens
IFS="$OIFS"

