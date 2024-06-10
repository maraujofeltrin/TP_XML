#!/bin/bash

dos2unix cte.sh &> /dev/null
dos2unix extract_nascar_data.xq &> /dev/null
dos2unix generate_fo.xsl &> /dev/null
dos2unix fop-2.9/fop/fop* &> /dev/null
dos2unix fop-2.9/fop* &> /dev/null
dos2unix fop-2.9/* &> /dev/null

source cte.sh


if [ $# -ne 2 ]
then
    ERRORES=1    
fi

if [ $ERRORES -eq 0 ]
then
    year="$1" 
    type="$2"
    if [ $1 -lt 2013 ] || [ $1 -gt 2024 ]
    then 
        ERRORES=2     
    fi 
    if [ $2 != "sc" ] && [ $2 != "xf" ] && [ $2 != "cw" ] && [ $2 != "go" ] && [ $2 != "mc" ]
    then
  
        ERRORES=3      
    fi
fi
if [ $ERRORES -eq 0 ]
then 
    curl https://api.sportradar.com/nascar-ot3/$type/$year/drivers/list.xml?api_key=${SPORTRADAR_API} -o drivers_list_a.xml &> /dev/null
    status=$?
    sleep 2
    curl https://api.sportradar.com/nascar-ot3/$type/$year/standings/drivers.xml?api_key=${SPORTRADAR_API} -o drivers_standings_a.xml &> /dev/null
    if [ $? -ne 0 ] || [ $status -ne 0 ] 
    then
        ERRORES=4  
        
    fi
    
        sed '/stylesheet/d' drivers_list_a.xml > drivers_list_b.xml
        sed 's/xmlns="[^"]*"//g' drivers_list_b.xml > drivers_list.xml
        sed '/stylesheet/d' drivers_standings_a.xml > drivers_standings_b.xml
        sed 's/xmlns="[^"]*"//g' drivers_standings_b.xml > drivers_standings.xml

        rm drivers_list_a.xml drivers_list_b.xml drivers_standings_a.xml drivers_standings_b.xml
fi
    java net.sf.saxon.Query -q:extract_nascar_data.xq errno=$ERRORES -o:nascar_data.xml &> /dev/null
    java net.sf.saxon.Transform -s:nascar_data.xml -xsl:generate_fo.xsl -o:nascar_page.fo &> /dev/null
    ./fop-2.9/fop/fop -fo nascar_page.fo -pdf nascar_report.pdf &> /dev/null

    if [ $ERRORES -eq 0 ]
    then
        rm drivers_list.xml drivers_standings.xml 
    fi

    rm nascar_data.xml nascar_page.fo
