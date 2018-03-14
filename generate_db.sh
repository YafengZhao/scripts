#!/bin/bash - 
#===============================================================================
#
#          FILE: generate_db.sh
# 
#         USAGE: ./generate_db.sh 
# 
#   DESCRIPTION: 
# 
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Yafeng Zhao (), zhaoyafeng0615@163.com
#  ORGANIZATION: 
#       CREATED: 03/14/2018 15:08
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

function generate_database() 
{
	echo "generate cscope database"
	cscope_file="cscope.file"
	find `pwd` -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.cxx" -o -name "*.h" -o -name "*.hpp" -o -name "*.java" -o -name "*.py" > $cscope_file 
	cscope -bqv -i $cscope_file

	echo "generate ctags"
	ctags --extra="+qf" --totals `find . -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.cxx" -o -name "*.h" -o -name "*.hpp" -o -name "*.java" -o -name "*.py"`
}

generate_database
