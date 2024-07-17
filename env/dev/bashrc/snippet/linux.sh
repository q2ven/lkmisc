checkpatch() {
    if [ $1 -le 0 ]; then
	echo "Usage: $0 NR_PATCHES [MAX_LINE_LENGTH]"
	echo "NR_PATCHES must be greater than 0"
	return 1
    fi

    NR_PATCHES=$(($1 - 1))
    MAX_LINE_LENGTH=$2

    if [ $# -ne 2 ]; then
	MAX_LINE_LENGTH=100
    fi

    for i in $(seq 0 ${NR_PATCHES})
    do
	git log --oneline HEAD~${i}...HEAD~$((${i} + 1))
	echo -e ''
	git show --format=email HEAD~${i} | ./scripts/checkpatch.pl --strict --max-line-length=${MAX_LINE_LENGTH}
	echo -e '\n\n'
    done
}

get_maintainer() {
    if [ $1 -le 0 ]; then
	echo "Usage: $0 NR_PATCHES"
	echo "NR_PATCHES must be greater than 0"
	return 1
    fi

    NR_PATCHES=$(($1 - 1))

    for i in $(seq 0 ${NR_PATCHES})
    do
	git log --oneline HEAD~${i}...HEAD~$((${i} + 1))
	echo -e ''
	git show --format=email HEAD~${i} | ./scripts/get_maintainer.pl
	echo -e '\n\n'
    done
}
