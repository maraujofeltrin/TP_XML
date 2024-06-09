#!/bin/bash

source cte.sh

if [ $# -ne 2 ]
then
    ERRORES=1    # ERRORES = 1 "<error>Cantidad de parametros incorrecta </error>."
fi

if [ $ERRORES -eq 0 ]
then
    year="$1" 
    type="$2"
    if [ $1 -lt 2013 ] || [ $1 -gt 2024 ]
    then 
        
        ERRORES=2     #"<error>Año ${year} inválido.</error>\n"
    fi 
    if [ $2 != "sc" ] && [ $2 != "xf" ] && [ $2 != "cw" ] && [ $2 != "go" ] && [ $2 != "mc" ]
    then
  
        ERRORES=3      #"<error>El Tipo ${type} es inválido.</error>\n"
    fi
fi
if [ $ERRORES -eq 0 ]
then 
    #curl https://api.sportradar.com/nascar-ot3/$type/$year/drivers/list.xml?api_key=${SPORTRADAR_API} -o drivers_list.xml &> /dev/null
    #status=$?
    #sleep 2
    #curl https://api.sportradar.com/nascar-ot3/$type/$year/standings/drivers.xml?api_key=${SPORTRADAR_API} -o drivers_standings.xml &> /dev/null
    #if [ $? -ne 0 ] || [ $status -ne 0 ] 
    #then
    #    ERRORES=4   #"<error>Hubo un error al descargar los archivos.</error>\n"
    #fi
    echo "todo bien"
fi
    java net.sf.saxon.Query extract_nascar_data.xq errno=$ERRORES > nascar_data.xml &> /dev/null
    java net.sf.saxon.Transform -s:nascar_data.xml -xsl:generate_fo.xsl -o:nascar_page.fo &> /dev/null
    ./fop-2.9/fop/fop -fo nascar_page.fo -pdf nascar_report.pdf &> /dev/null
