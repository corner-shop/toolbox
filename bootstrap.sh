#!/usr/bin/env bash

set -e

B2_URL="https://f001.backblazeb2.com/file/toolbox-bundles"

cd /home/user/.pyenv/versions
BUNDLES="
2.7.16
3.6.9
"
for BUNDLE in ${BUNDLES}
do
	if [ ! -e ${BUNDLE} ]; then
		echo "Downloading ${BUNDLE} ..."
		wget -q "${B2_URL}/pyenv/${BUNDLE}.tgz" -O /tmp/${BUNDLE}.tgz
		tar xzf /tmp/${BUNDLE}.tgz
		rm -f /tmp/${BUNDLE}.tgz
	fi
done

cd /home/user/.rubies
BUNDLES="
2.3.3
2.6.3
"
for BUNDLE in ${BUNDLES}
do
	if [ ! -e ${BUNDLE} ]; then
		echo "Downloading ${BUNDLE} ..."
		wget -q "${B2_URL}/rubies/${BUNDLE}.tgz" -O /tmp/${BUNDLE}.tgz
		tar xzf /tmp/${BUNDLE}.tgz
		rm -f /tmp/${BUNDLE}.tgz
	fi
done

pkenv install 1.4.2
pkenv install 1.2.5
pkenv install 1.3.5

tfenv install 0.11.14
