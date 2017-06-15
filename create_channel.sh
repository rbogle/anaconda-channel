#!/bin/bash

chan_loc=$(pwd)/mychannel
chan_url='file://'${chan_loc}
numpy='1.11'
python='2.7'

function help() {
  echo -e "\n This script builds the subdirectories as anaconda packages and deploys them. \n"
  echo -e  "\t -h print this help"
  echo -e  "\t -c <path> set location for packages to be deployed default: $chan_loc"
  echo -e  "\t -u <url> set url for channel, default: $chan_url"
  echo -e  "\t -n <numpy> set numpy version for compile, default: v$numpy"
  echo -e  "\t -p <python> set python version for compile, default: v$python\n"
  exit 1;
}

function confirm(){

  echo "This program will build all available packages in this directory"
  echo "With the options:"
  echo "--numpy $numpy"
  echo "--python $python"
  echo "And deploy them to $chan_loc as conda repository $chan_url. "
  read -p "Is this what you want? (y or n)" yn
  case $yn in
      [Yy]* ) return;;
      [Nn]* ) help;;
      *) echo "Please answer y or n";;
  esac

}
# getopts and confirm choices/defaults
if (($# == 0)); then
   confirm
else
  while getopts ":hc:u:n:p:" opt; do
    case $opt in
      h)
        help
        exit 0;
        ;;
      c)
        chan_loc=$OPTARG
        ;;
      u)
        chan_url=$OPTARG
        ;;
      n)
        numpy=$OPTARG
        ;;
      p)
        python=$OPTARG
        ;;
      \?)
        help
        exit 1;
        ;;
      :)
        echo "Option -$OPTARG reqires and argument" >&2
        exit 1;
        ;;
    esac
  done
  confirm
fi

# mkdirs for channel
if [ ! -d $chan_loc ]; then
  mkdir -p $chan_loc
fi

# perform builds
# with --output-folder channel folders will be created and indexed
conda build purge
for i in $(ls -d */); do
  if [ ${i} != 'mychannel/' ]; then
    # build
    echo -e "\n building conda package: ${i%%/} with numpy $numpy & python $python"
    conda build --output-folder=$chan_loc ${i%%/} --numpy $numpy --python $python
  fi
done
# add the channel to conda configure
conda config --add channels $chan_url
