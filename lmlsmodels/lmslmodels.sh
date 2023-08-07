#!/bin/bash
#
# This utility will traverse an LM Studio model directory and create links into another preferred directory
# This reduces a need to copy models across directories and also allows all model fils to be collocated into a flat folder structure when using other tools
#

usage() { 
    echo "Usage: $0 -m <LMS model directory> [-t <target directory>] [-p <pattern>] [-fivsl]" 
    echo "       -m: Specifies the source LM Studio model directory"
    echo "       -t: Specifies the target directory. By default the current directory is assumed"
    echo "       -f: Force Link.  I.e. remove any existing link and relink"
    echo "       -p: Case insensitive pattern match files to link. Otherwise all .bin files in the directory are linked"
    echo "       -i: Interactive - confirm each potential overwrite"
    echo "       -v: Verbose. Show additional detail while processing"
    echo "       -s: Symbolic link. Creates a pointer and works across file systems (not always honoured)"
    echo "       -l: List the available model files in the source LM studio directory"
    exit 1
}

# Parse the options
OPTS=""
LIST=""
while getopts ":m:t:p:fvils" o; do
    case "${o}" in
        m) # LMS model directory
            MDIR=${OPTARG}
            if [ ! -d ${MDIR} ]; then
               echo "Source directory '${MDIR} does not exist."
               usage
            fi
            ;;
        t) # Target link directory
            TDIR=${OPTARG}
            if [ ! -d ${TDIR} ]; then
               echo "Destination directory '${TDIR} does not exist."
               usage
            fi
            ;;
        p) # Pattern to match
            PATTERN=${OPTARG}
            ;;
        f) # Force overwrite
            OPTS="${OPTS}f"
            ;;
        l) # Interactive confirmation of overwrite
            LIST='t'
            ;;
        i) # Interactive confirmation of overwrite
            OPTS="${OPTS}i"
            ;;
        v) # Verbose
            OPTS="${OPTS}v"
            ;;
        s) # Symbolic link (not a hard inode link)
            OPTS="${OPTS}s"
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${MDIR}" ] ; then
    echo "You must specific a source model directory for the models."
    usage
fi

if [ -z "${TDIR}" ] && [ -z "${LIST}" ] ; then
    echo "Using current directory as target directory for linked files."
    TDIR="."
fi

if [ ! -z "${OPTS}" ] ; then
    OPTS="-${OPTS}"
fi

if [ -z "${PATTERN}" ] ; then
    RE="*.bin"
else
    RE="*${PATTERN}*.bin"
fi

if [ ! -z "${LIST}" ] ; then
    echo "Listing matching files... no linking will be done"
fi

# Collate the model files.  They are assumed to end in 'bin'

OIFS="$IFS"; IFS=$'\n'		# Cater for spaces within file and directory names

for i in $(find ${MDIR} -iname "${RE}" -print );
do
    if [ -z ${LIST} ]; 
    then
        ln ${OPTS} ${i} ${TDIR}/$(basename $i)
    else
        echo $i
    fi
done

IFS="$OIFS"			# Reset

exit 0


