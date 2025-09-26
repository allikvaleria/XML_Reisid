<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>

	<xsl:template match="/">
		<strong>Näitame kõik reisid</strong>
		<xsl:for-each select="//reis">
			<h1>
				<xsl:value-of select="saabumine"/>
			</h1>
		</xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
