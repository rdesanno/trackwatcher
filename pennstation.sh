#!/bin/bash
TEMP_FILE=./nyps.tmp
curl -s http://dv.njtransit.com/mobile/tid-mobile.aspx?SID=NY > $TEMP_FILE

sed '
	/^<td align=/s/><\/td/>NULL</g
	s/<[^>]*>//g
	s/&nbsp;&#9992//g
	s///
	s/>  */>/g
	s/*  </</g
 	/^$/d
	/^    *$/d
	/^NJ T/d
	/^google/d
	/^window/,$d
	/^DEPARTSTOTRKLINETRAIN/d
	/Note Track Change/d
	/Select a train to view/d
	/-->/d
	s/&nbsp;/ /
	/^$/{N;/^\n$/d;}
	s/ -SECNULL//g
	s/$/,/
 ' $TEMP_FILE | paste - - - - - - - | column -t -s ","

rm -f $TEMP_FILE
