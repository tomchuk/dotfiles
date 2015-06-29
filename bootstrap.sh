#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	for file in `ls -1a | egrep -v '^(.git|.DS_Store|bootstrap.sh|README.md|LICENSE-MIT.txt|init|bin|brew.sh|.|..)$'`
	do
		test -h "$HOME/$file" && rm "$HOME/$file" || echo "Skipping $file"
		ln -sf "`pwd`/$file" "$HOME/$file"
	done
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
