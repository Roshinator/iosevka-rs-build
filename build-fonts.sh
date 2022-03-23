#!/bin/bash
mkdir Iosevka
cp private-build-plans.toml Iosevka/private-build-plans.toml
cd Iosevka
git init
git remote add origin https://github.com/be5invis/iosevka
git fetch --depth 1 origin $1
git checkout FETCH_HEAD
echo "Make sure NPM and TTFAutoHint are installed"
npm install

declare -a builtItems
builtItems=(iosevka-rs iosevka-rs-slab iosevka-rs-mono iosevka-rs-mono-slab iosevka-rs-terminal iosevka-rs-terminal-slab)

for str in ${builtItems[@]}; do
    npm run build -- contents::$str
    cp -r dist/$str ../$str
done
cd ..
rm -rf Iosevka
