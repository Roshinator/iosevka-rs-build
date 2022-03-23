mkdir Iosevka
cp private-build-plans.toml Iosevka/private-build-plans.toml
cd Iosevka
git init
git remote add origin https://github.com/be5invis/iosevka
git fetch --depth 1 origin $1
if npm ; then
    echo "Found npm"
else
    echo "Please install npm"
    exit 1
fi
if ttfautohint ; then
    echo "Found ttfautohint"
else
    echo "Please install ttfautohint"
    exit 1
fi
npm install

builtItems = ("iosevka-rs" "iosevka-rs-slab" "iosevka-rs-mono" "iosevka-rs-mono-slab" "iosevka-rs-terminal" "iosevka-rs-terminal-slab")

for str in ${myArray[@]}; do
    npm run build -- contents::$str
    cp -r dist/$str ../$str
done
cd ..
rm -rf Iosevka