source cte.sh

if [ $# -ne 2 ]
then
    ERRORES+="Error: Cantidad de parametros incorrecta\n"
fi



echo "${ERRORES}"