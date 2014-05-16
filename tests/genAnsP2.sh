#!/bin/bash

if [ -z $1 ]; then
	# If there is no command line arg, 
	$0 all
elif [ "x$1" == "xall" ]; then
	# Run all tests
	$0 $(dirname $0)/project2/*/*.rc
elif [ -d $1 ]; then
	# Run the tests in the specified folder
	$0 $1/*.rc
else
	# We want to work out of the tests dir
	pushd $(dirname $0) >> /dev/null

	
	startTime=$(date +%s)
	numMissing=0

	if [ -e "../RC" ]; then
		for file in $@; do
			passed="1"

			file=`echo $file | cut -c7-`
			ans="`dirname $file`/`basename $file .rc`.ans.out"
			input="`dirname $file`/`basename $file .rc`.input"

			if [ ! -e $ans ]; then

			echo -ne "$file ..." 
			
				pushd .. > /dev/null
				./rcc tests/$file &> tests/.out
				popd > /dev/null

				ans="`dirname $file`/`basename $file .rc`.ans.out"
			
				pushd .. > /dev/null
				./rcc tests/$file &> tests/.out
				popd > /dev/null
				if [ -e ../a.out ]; then
					if [ -e $input ]; then
						../a.out < $input &> $ans
					else 
						../a.out &> $ans
					fi
				fi
					
				#../RC $file &> $ans
				echo -e '\e[0;33m' generated .ans.out | tee -a $logfile; tput sgr0 | tee -a $logfile
				numMissing=$(($numMissing+1))
			fi
		done
	else
		echo RC is missing.
	fi

	endTime=$(date +%s)

	echo -e === Generated $numMissing .ans.out files in $((endTime-startTime)) seconds. | tee -a $logfile

	popd >> /dev/null
fi
