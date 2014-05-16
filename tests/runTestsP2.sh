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
	
	logfile="logs/`date +%Y%m%d-%H%M%S`.log"
	errorlog="logs/`date +%Y%m%d-%H%M%S`-error.log"

	if [ -e logs/p2-lasterror.log ]; then
		rm logs/p2-lasterror.log
	fi
	if [ -e logs/p2-last.log ]; then
		rm logs/p2-last.log
	fi

	echo -n '' > $logfile
	echo -n '' > $errorlog
	pushd logs >> /dev/null
	ln -s "`basename $logfile`" p2-last.log
	ln -s "`basename $errorlog`" p2-lasterror.log
	popd >> /dev/null
	
	startTime=$(date +%s)
	numPassed=0
	numFailed=0
	numMissing=0

	tput sgr0 | tee $logfile
	echo Running $# tests. | tee -a $logfile

	if [ -e "../RC" ]; then
		for file in $@; do
			passed="1"

			file=`echo $file | cut -c7-`
            ans="`dirname $file`/`basename $file .rc`.ans.out"
#ans="./project2/`basename $file .rc`.ans.out"
            input="`dirname $file`/`basename $file .rc`.input"

			echo -ne "Running test $file ..." | tee -a $logfile
            

			if [ -e $ans ]; then
				pushd .. > /dev/null
                ./rcc tests/$file &> tests/.out
                ./RC tests/"`dirname $file`/`basename $file`"
                make run 1 > /dev/null 2 > /dev/null
				popd > /dev/null
				if [ -e ../a.out ]; then
					if [ -e $input ]; then
						../a.out < $input &> .out
					else 
						../a.out &> .out
					fi
				fi
				diff .out $ans &> .diff
				if [ $? == 1 ]; then
					passed="0"
				fi
				
				if [ $passed == "1" ]; then
					numPassed=$(($numPassed+1))
					echo -e '\e[0;32m' passed | tee -a $logfile; tput sgr0 | tee -a $logfile
				else
					echo -e '\e[0;31m' failed | tee -a $logfile; tput sgr0 | tee -a $logfile
					echo Failed $file >> $errorlog
					echo '===========================================' >> $errorlog
					cat .diff >> $errorlog
					echo '===========================================' >> $errorlog
					echo '' >> $errorlog
					echo '' >> $errorlog
					numFailed=$(($numFailed+1))
				fi

				rm .out .diff
			else
				#../RC $file &> $ans
				echo -e '\e[0;33m' .ans.out missing | tee -a $logfile; tput sgr0 | tee -a $logfile
				numMissing=$(($numMissing+1))
			fi
		done
	else
		echo RC is missing.
	fi

	endTime=$(date +%s)

	echo -ne === Ran $# tests in $((endTime-startTime)) seconds. | tee -a $logfile
	echo -ne '\e[0;32m' $numPassed passed. | tee -a $logfile
	echo -ne '\e[0;31m' $numFailed failed. | tee -a $logfile
	if [ "$numMissing" != "0" ]; then
		echo -ne '\e[0;33m' $numMissing missing .ans.out files. | tee -a $logfile
	fi
	echo -e '' | tee -a $logfile; tput sgr0 | tee -a $logfile

	popd >> /dev/null
fi
