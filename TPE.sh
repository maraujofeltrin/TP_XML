#!/usr/bin/bash

source cte.sh

if [ $# -ne 2 ]
then
    ERRORES+="<error>Cantidad de parametros incorrecta </error>.\n"
fi

if [ -z "$ERRORES" ]
then
    if [ $1 -lt 2013 ] || [ $1 -gt 2024 ]
    then 
        year="$1" 
        ERRORES+="<error>Año ${year} inválido.</error>\n"
    fi 
    if [ $2 != "sc" ] && [ $2 != "xf" ] && [ $2 != "cw" ] && [ $2 != "go" ] && [ $2 != "mc" ]
    then
        type="$2"
        ERRORES+="<error>ETipo ${type} inválido.</error>\n"
    fi

    if [ -z "$ERRORES" ]
    then 
        echo "todo en condiciones"
        ./fop-2.9/fop/fop -fo ./fop-2.9/fop/examples/fo/basic/simple.fo -pdf example.pdf &> /dev/null

    fi
fi



echo -e $ERRORES