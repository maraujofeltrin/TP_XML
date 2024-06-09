declare option saxon:output "encoding=UTF-16";
declare option saxon:output "indent=yes";
declare variable $errno external;
if($errno != "0") then
<nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="nascar_data.xsd"> 
        {
            if ($errno = "1") then
                <error> The number of parameters must be 2 </error>
            else if ($errno = "2") then
                <error> The year is invalid </error>
            else if ($errno = "3") then
                <error> The type of parameter is invalid </error>
            else if ($errno = "4") then
                <error> Error while downloading files </error>
            else ()
        }
    </nascar_data>
else
let $series := doc("drivers_standings.xml")//series
return
    <nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="nascar_data.xsd"> 
        <year>{data($series/season/@year)}</year>
        <serie_type>{data($series/@name)}</serie_type>
        <drivers> 
        {
            for $driver in doc("drivers_list.xml")//series/season/driver
            let $rank := $series/season/driver[@id = $driver/@id]/@rank
            where $rank
            order by number($rank)
            return
                <driver> 

                    <full_name>{data($driver/@full_name)}</full_name>
                    <country>{data($driver/@country)} </country> 
                    <birth_date>{data($driver/@birthday)}</birth_date>
                    <birth_place>{data($driver/@birth_place)}</birth_place>
                    <rank>{data($rank)}</rank>
                    {
                        if (count($driver/car) > 0 )
                        then <car>{data($driver/car[not(preceding-sibling::car)]/manufacturer/@name)}</car> 
                        else ()
                    }
                    <statistics> 
                        <season_points>{data($series/season/driver[@id = $driver/@id]/@points)}</season_points> 
                        <wins>{data($series/season/driver[@id = $driver/@id]/@wins)}</wins>
                        <poles>{data($series/season/driver[@id = $driver/@id]/@poles)}</poles> 
                        <races_not_finished>{data($series/season/driver[@id = $driver/@id]/@dnf)}</races_not_finished> 
                        <laps_completed>{data($series/season/driver[@id = $driver/@id]/@laps_completed)}</laps_completed> 
                    </statistics> 
                </driver> 
        }
        </drivers> 
    </nascar_data>