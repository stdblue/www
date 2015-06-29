<?xml version="1.0" encoding="Shift_JIS" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="Shift_JIS"/>

<xsl:template match="/">
<div style="text-align:center;">
<table border="1" width="80%">
<xsl:for-each select="catalog/gift">

<xsl:choose>
<xsl:when test="@type='picture'">
<tr>
  <th colspan="3"><xsl:value-of select="title" /></th>
</tr>
<tr>
  <td rowspan="2" align="center">
    <xsl:element name="a">
      <xsl:attribute name="href"><xsl:value-of select="link" /></xsl:attribute>
      <xsl:element name="img">
        <xsl:attribute name="border">0</xsl:attribute>
        <xsl:attribute name="src"   ><xsl:value-of select="link" /></xsl:attribute>
        <xsl:attribute name="width" ><xsl:value-of select="small/@width" /></xsl:attribute>
        <xsl:attribute name="height"><xsl:value-of select="small/@height" /></xsl:attribute>
      </xsl:element>
    </xsl:element>
  </td>
  <th width="100"><xsl:value-of select="date" /></th>
  <td rowspan="2"><xsl:value-of select="description" /></td>
</tr>
<tr>
  <td>
    <xsl:element name="a">
      <xsl:attribute name="href"><xsl:value-of select="sender/@site" /></xsl:attribute>
      <xsl:value-of select="sender" />
    </xsl:element>
    さまから
  </td>
</tr>
</xsl:when>

<xsl:when test="@type='text'">
</xsl:when>

<xsl:otherwise>
</xsl:otherwise>

</xsl:choose>
</xsl:for-each>
</table>
</div>
</xsl:template>

</xsl:stylesheet>
