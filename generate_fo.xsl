<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:template match="/">
    <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
    <fo:layout-master-set>
        <fo:simple-page-master master-name="first" margin-right="1.5cm" margin-left="1.5cm" margin-bottom="2cm" margin-top="1cm" page-width="21cm" page-height="29.7cm">
            <fo:region-body margin-top="1cm"/>
            <fo:region-before extent="1cm"/>
            <fo:region-after extent="1.5cm"/>
        </fo:simple-page-master>
    </fo:layout-master-set>
    <fo:page-sequence master-reference="first">
        <fo:static-content flow-name="xsl-region-before">
            <fo:block line-height="14pt" font-size="10pt" text-align="end">TPE 2024 1Q - Grupo 1</fo:block>
        </fo:static-content>

        <xsl:choose>
            <xsl:when test="/nascar_data/error">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block font-size="10pt" color="red">Error: <xsl:value-of select="/nascar_data/error"/></fo:block>
                </fo:flow>
            </xsl:when>
            <xsl:otherwise>
        
        <fo:flow flow-name="xsl-region-body">
            <fo:block font-size="14pt" space-before.optimum="15pt" space-after.optimum="15pt">
                    Drivers for
                    <xsl:value-of select="/nascar_data/serie_type"/>
                    for
                    <xsl:value-of select="/nascar_data/year"/>
                    season
            </fo:block>
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-number="1" column-width="14%"/>
                <fo:table-column column-number="2" column-width="10%"/>
                <fo:table-column column-number="3" column-width="10%"/>
                <fo:table-column column-number="4" column-width="14%"/>
                <fo:table-column column-number="5" column-width="9%"/>
                <fo:table-column column-number="6" column-width="8%"/>
                <fo:table-column column-number="7" column-width="7%"/>
                <fo:table-column column-number="8" column-width="7%"/>
                <fo:table-column column-number="9" column-width="7%"/>
                <fo:table-column column-number="10" column-width="7%"/>
                <fo:table-column column-number="11" column-width="7%"/>
                
                <fo:table-body border-width="1pt" border-style="solid" >
                        <fo:table-row background-color="rgb(215,245,250)" >
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">Name</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">Country</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">Birth date</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">Birth place</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">Car manufacturer</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">Rank</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">Season points</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">Wins</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">Poles</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">Unfinished races</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">Completed laps</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    
                
                        <xsl:for-each select="/nascar_data/drivers/driver">
                    <fo:table-row>
                        
                        <fo:table-cell>
                            
                                <fo:block font-size="8pt" text-align="center">
                                    <xsl:value-of select="full_name"/>
                                </fo:block>
                            
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">
                                <xsl:value-of select="country"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">
                                <xsl:value-of select="birth_date"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">
                                <xsl:value-of select="birth_place"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">
                                <xsl:if test="not(car)">-</xsl:if>
                                <xsl:value-of select="car"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt"  text-align="center">
                                <xsl:attribute name="color">
                                    <xsl:choose>
                                        <xsl:when test="rank &lt;= 3">green</xsl:when>
                                        <xsl:otherwise>black</xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <xsl:value-of select="rank"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">
                                <xsl:value-of select="statistics/season_points"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">
                                <xsl:value-of select="statistics/wins"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">
                                <xsl:value-of select="statistics/poles"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">
                                <xsl:value-of select="statistics/races_not_finished"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block font-size="8pt" text-align="center">
                                <xsl:value-of select="statistics/laps_completed"/>
                            </fo:block>
                        </fo:table-cell>
                    
            </fo:table-row>
        </xsl:for-each>
    </fo:table-body>
  
</fo:table>
</fo:flow>
</xsl:otherwise>
</xsl:choose>
</fo:page-sequence>
</fo:root>
</xsl:template>
</xsl:stylesheet>