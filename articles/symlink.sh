#! /bin/sh
export CWD=$(pwd)
for i in $(find . -type d); do
        cd $i
        ln -s $(find . -type f -name "1-*.md") README.md
        cd $CWD;
done
