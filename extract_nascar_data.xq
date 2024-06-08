let $series := doc("drivers_standings.xml")//series
return
    <nascar_data xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="nascar_data.xsd"> &#xa;
        <year>{data($series/season/@year)}</year> &#xa;
        <serie_type>{data($series/@name)}</serie_type> &#xa;
        <drivers> &#xa;
        {
            for $driver in doc("drivers_list.xml")//series/season/driver
            let $rank := $series/season/driver[@id = $driver/@id]/@rank
            where $rank
            order by number($rank)
            return
                <driver> &#xa;

                    <full_name>{data($driver/@full_name)}</full_name> &#xa;
                    <country>{data($driver/@country)} </country> &#xa;
                    <birth_date>{data($driver/@birthday)}</birth_date> &#xa;
                    <birth_place>{data($driver/@birth_place)}</birth_place> &#xa;
                    <rank>{data($rank)}</rank> &#xa;
                    {
                        if (count($driver/car) > 0 )
                        then <car>{data($driver/car[not(preceding-sibling::car)]/manufacturer/@name)}</car> 
                        else ()
                    }&#xa;
                    <statistics> &#xa;
                        <season_points>{data($series/season/driver[@id = $driver/@id]/@points)}</season_points> &#xa;
                        <wins>{data($series/season/driver[@id = $driver/@id]/@wins)}</wins> &#xa;
                        <poles>{data($series/season/driver[@id = $driver/@id]/@poles)}</poles> &#xa;
                        <races_not_finished>{data($series/season/driver[@id = $driver/@id]/@dnf)}</races_not_finished> &#xa;
                        <laps_completed>{data($series/season/driver[@id = $driver/@id]/@laps_completed)}</laps_completed> &#xa;
                    </statistics> &#xa;
                </driver> 
        }
        </drivers> &#xa;
    </nascar_data>