<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:g="http://www.gtk.org/introspection/core/1.0"
  xmlns:c="http://www.gtk.org/introspection/c/1.0"
  xmlns:glib="http://www.gtk.org/introspection/glib/1.0">
  <xsl:output method="text" encoding="utf-8"/>

  <xsl:template match="text()" />

  <xsl:template match="*"/>

  <xsl:template match="/">
    <xsl:apply-templates select="//g:class | //g:interface"/>
  </xsl:template>

  <xsl:template match="g:class[@parent!='GObject.Object'] | g:interface[@parent!='GObject.Object']">
    <xsl:text>class </xsl:text>
    <xsl:value-of select="@name"/>
    <xsl:if test="@abstract='1' or name()='interface'">
      <xsl:text> abstract</xsl:text>
    </xsl:if>
    <xsl:text> set wrap wrapsig : </xsl:text>
    <xsl:value-of select="@parent"/>
    <xsl:text> {&#xA;</xsl:text>
    <xsl:apply-templates select="*"/>
    <xsl:text>}&#xA;&#xA;</xsl:text>
  </xsl:template>

  <xsl:template match="g:property">
   <xsl:text>  &quot;</xsl:text>
   <xsl:value-of select="@name"/>
   <xsl:text>&quot; </xsl:text>
   <xsl:apply-templates mode="type" select="g:type"/>
   <xsl:text> : </xsl:text>
   <xsl:if test="not(@readable='0')">
    <xsl:text>Read</xsl:text>
    <xsl:if test="@writable='1'">
      <xsl:text> / </xsl:text>
    </xsl:if>
   </xsl:if>
   <xsl:if test="@writable='1'">
    <xsl:text>Write</xsl:text>
   </xsl:if>
   <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template match="glib:signal">
   <xsl:text>  signal </xsl:text>
   <xsl:value-of select="translate(@name,'-','_')"/>
   <xsl:text> : </xsl:text>
   <xsl:apply-templates mode="type" select="g:parameters/g:parameter/g:type"/>
   <xsl:text> -> </xsl:text>
   <xsl:apply-templates mode="type" select="g:return-value/g:type"/>
   <xsl:text>&#xA;</xsl:text>
  </xsl:template>

  <xsl:template match="g:method">
   <xsl:text>  method </xsl:text>
   <xsl:value-of select="@name"/>
   <xsl:text> : "</xsl:text>
   <xsl:apply-templates mode="type" select="g:parameters/g:parameter"/>
   <xsl:apply-templates mode="type" select="g:return-value/g:type"/>
   <xsl:text>"&#xA;</xsl:text>
  </xsl:template>

  <xsl:template mode="type" match="g:parameter">
    <xsl:apply-templates mode="type" select="g:type"/>
    <xsl:text> -> </xsl:text>
  </xsl:template>

  <xsl:template mode="type" match="g:type">
    <xsl:value-of select="@name"/>
  </xsl:template>

  <xsl:template mode="type" match="g:array">
    <xsl:apply-templates mode="type" select="g:type"/>
    <xsl:text>_array</xsl:text>
  </xsl:template>

  <xsl:template mode="type" match="*">
    ??<xsl:copy-of select="name()"/>??
  </xsl:template>

</xsl:stylesheet>
