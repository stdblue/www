<?xml version="1.0" encoding="Shift_JIS" ?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:output method="html" encoding="Shift_JIS"/>

<xsl:template match="/">
<html lang="ja">
<head>
	<title>Illuminated! Gifts room</title>

	<!-- �X�^�C���V�[�g�w�� -->
	<link href="/vene/css/illuminated.css" rel="stylesheet" type="text/css" />
</head>
<body>
<a name="DocumentTop"></a>
<hr />
<h2>�������̊�</h2>
<hr />
<div class="abstract">
�@�u�[���ς݁v�ɂ����蒸�����l�X�ȑ��蕨���R(߁͡)ɂ����˂���ю�������ꏊ�ł��B<br />
�@��낵����΁A�F��������y���݂��������B
</div>
<br />
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
    ���܂���
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
<br />
<br />
<div class="backto"><a href="IndexPage.aspx">Index �ɖ߂�</a></div>
<br />
<hr />
<br />
<br />
</body>
</html>
</xsl:template>

<xsl:template match="catalog">
</xsl:template>


</xsl:stylesheet>
