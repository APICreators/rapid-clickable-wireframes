#!/bin/sh
set -e
set -x

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")

rm -rf target
mkdir -p target/inter
mkdir -p target/static

for PAGE in $(cd $SCRIPTPATH/pages && find . | grep '\.uml$'); do
  # embed title and content
  FORMATTED_TITLE=$(echo $PAGE | sed 's/\.uml//' | sed 's/\([a-z]\)\([A-Z]\)/\1 \2/g' | sed 's/^\.\///')
  TITLE="$FORMATTED_TITLE" CONTENT="$(cat $SCRIPTPATH/pages/$PAGE)" \
    envsubst < $SCRIPTPATH/config/template.puml > $SCRIPTPATH/target/inter/$PAGE

  # convert to svg
  (cd $SCRIPTPATH/target/inter && java -jar /opt/plantuml.jar -tsvg $PAGE)

  # format xml
  SVG_PAGE="$(cd $SCRIPTPATH/pages && echo $PAGE | sed 's/\.uml$/.svg/')"
  (cd $SCRIPTPATH/target/inter && xmllint --format $SVG_PAGE > $SVG_PAGE.new && mv $SVG_PAGE.new $SVG_PAGE)
  # remove comments
  (cd $SCRIPTPATH/target/inter && xmlstarlet ed -d '//comment()' $SVG_PAGE > $SVG_PAGE.new && mv $SVG_PAGE.new $SVG_PAGE)
done

for PAGE in $(cd $SCRIPTPATH/target/inter && find . | grep '\.svg$'); do
  # add links
  for LINK_TARGET in $(cd $SCRIPTPATH/target/inter && find . | grep '\.svg$'); do
    LINK_TEXT=$(echo $LINK_TARGET | sed 's/\.svg//' | sed 's/\([a-z]\)\([A-Z]\)/\1 \2/g' | sed 's/^\.\///')
    sed -i "s/$LINK_TEXT/<a target=\"_top\" href=\"$(basename $LINK_TARGET | sed 's/svg$/html/')\">$LINK_TEXT<\/a>/" $SCRIPTPATH/target/inter/$PAGE
  done

  # make static_html page
  cp $SCRIPTPATH/target/inter/$PAGE $SCRIPTPATH/target/static/
  HTML_NAME="$(echo $PAGE | sed "s/svg$/html/")" 
  IMG_SRC=$PAGE \
    envsubst < $SCRIPTPATH/config/template.html > $SCRIPTPATH/target/static/$HTML_NAME
  
done
