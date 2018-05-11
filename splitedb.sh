#!/bin/bash - 
#===============================================================================
#
#          FILE: splitedb.sh
# 
#         USAGE: ./splitedb.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Dr. Fritz Mehner (fgm), mehner.fritz@fh-swf.de
#  ORGANIZATION: FH Südwestfalen, Iserlohn, Germany
#       CREATED: 2018年05月12日 01:31
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

dbfile=$1
limite=$2
tablename="cities"

declare -i offset=0

recordscount=`sqlite3 $dbfile  "select count(*) from cities"`

echo $recordscount

tablescount=`expr $recordscount / $limite`

remain_records=`expr $recordscount % $limite`

if [ $remain_records -ne 0 ]; then 

	 tablescount=$((tablescount+1))
fi

echo $tablescount
for ((i=0; i<tablescount; i++))
do 
	
	echo "$dbfile.$i"
	subdb="$dbfile.$i"
	sqlite3 $dbfile '.schema cities' | sed '1s/cities/cities/' | sqlite3 "$subdb"
	sqlite3 $dbfile "attach \"$subdb\" as subdb" ".database" "insert into subdb.cities select * from main.cities limit $limite offset $offset" "select count(*) from subdb.cities"
	offset=$((offset+$limite))
done



