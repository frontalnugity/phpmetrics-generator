# genrate_metrics.sh
# Desxription:  A shell script to make it easy to generate static code reports using phpmetrics by Jean-François Lépine (see http://phpmetrics.org)
#
# Author:   Ted Nugent nuge@geniusfactor.ca
# Gihub:    https://github.com/frontalnugity/phpmetrics-generator






# get current commit head
REPORT_DIR='_metrics'
# get GIT commit name for report
GEN_DATE="$(date +'%Y-%m-%d [%H-%M-%S]')";

#generate output path'
OUTPUT_DIR=$REPORT_DIR'/'$GEN_DATE

PHPMETRICS_EXCLUDED='vendor,node_modules,storage'
PHPMETRICS_EXTENSIONS='php,sh,sql,vue,js,css,scss,json'

# auto-create metrics folder (if it doesn't exist)
if [ -d $REPORT_DIR ]; then
    echo "REPORT DIRECTOR exists"
   else
       mkdir $REPORT_DIR
fi

# auto-create rport output folder (if it doesn't exist)
if [ -d $REPORT_DIR/$GEN_DATE ]; then
        echo "METRICS DIRECTOR exists"
    else
        mkdir $REPORT_DIR/$GEN_DATE
fi

# generate metrics repprt
phpmetrics --exclude=$PHPMETRICS_EXCLUDED,$REPORT_DIR --extensions=$PHPMETRICS_EXTENSIONS --report-html=$OUTPUT_DIR --report-violations=$OUTPUT_DIR/violations.xml .


# generate index
(echo "<a href='./$GEN_DATE/index.html'>$GEN_DATE</A><br>\n"; cat $REPORT_DIR/index.html;) > $REPORT_DIR/$GEN_DATE.tmp
rm $REPORT_DIR/index.html
mv $REPORT_DIR/$GEN_DATE.tmp $REPORT_DIR/index.html

# open index of reports in your browser
open $REPORT_DIR/index.html
