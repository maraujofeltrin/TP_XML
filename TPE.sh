#!/bin/bash

source cte.sh

if [ $# -ne 2 ]
then
    ERRORES+="<error>Cantidad de parametros incorrecta </error>.\n"
fi

if [ -z "$ERRORES" ]
then
    year="$1" 
    type="$2"
    if [ $1 -lt 2013 ] || [ $1 -gt 2024 ]
    then 
        
        ERRORES+="<error>Año ${year} inválido.</error>\n"
    fi 
    if [ $2 != "sc" ] && [ $2 != "xf" ] && [ $2 != "cw" ] && [ $2 != "go" ] && [ $2 != "mc" ]
    then
  
        ERRORES+="<error>ETipo ${type} inválido.</error>\n"
    fi

    if [ -z "$ERRORES" ]
    then 
        curl https://api.sportradar.com/nascar-ot3/$type/$year/drivers/list.xml?api_key=${SPORTRADAR_API} -o drivers_list.xml
        status=$?
        sleep 2
        curl https://api.sportradar.com/nascar-ot3/$type/$year/standings/drivers.xml?api_key=${SPORTRADAR_API} -o drivers_standings.xml
        if [ $? -ne 0 ] || [ $status -ne 0 ] 
        then
            ERRORES+="<error>Hubo un error al descargar los archivos.</error>\n"
        fi

    fi
fi



echo -e $ERRORES