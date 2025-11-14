<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" indent="yes" encoding="utf-8"/>

	<xsl:template match="/reisid">
		<html>
			<head>
				<meta charset="utf-8"/>
				<title>Reisid</title>
				<style>
					h1 { font-family: Arial; margin-top: 30px; font-size:18px; }
					ul { font-family: Arial; margin:6px 0 16px 0; padding-left:18px; }
					li { margin-bottom: 4px; }
					.yellow { background: yellow; padding: 2px; display: inline-block; }
					.expensive { color: red; font-weight: bold; }
					table { border-collapse: collapse; width: 100%; margin-top: 20px; font-family: Arial; font-size:13px; }
					th, td { border: 1px solid #333; padding: 6px; text-align: left; vertical-align: top; }
					tr:nth-child(even) { background: #e9f5ff; }
					tr:nth-child(odd)  { background: #ffffff; }
				</style>
			</head>
			<body>

				<xsl:for-each select="reis[contains(lennujaam/hotel/transport, 'Lend') or contains(lennujaam/hotel/transport, 'lend')]">
					<xsl:sort select="number(lennujaam/hotel/@tarnid)" data-type="number" order="ascending"/>
					<h1>
						<xsl:value-of select="lennujaam/@nimi"/>
						(<xsl:value-of select="lennujaam/@kood"/>)
					</h1>

					<ul>
						<li>
							<xsl:text>Transport: </xsl:text>
							<xsl:value-of select="lennujaam/hotel/transport"/>
						</li>

						<li>
							<xsl:text>Hotell: </xsl:text>
							<xsl:value-of select="lennujaam/hotel/@hotellnimi"/>
						</li>

						<li>
							<xsl:text>Tärnid: </xsl:text>
							<xsl:value-of select="lennujaam/hotel/@tarnid"/>
						</li>

						<li>
							<span class="yellow">
								Lennu hind: <xsl:value-of select="lennujaam/hotel/lennu_hind"/>
							</span>
						</li>

						<li>
							<span class="yellow">
								Hotelli hind: <xsl:value-of select="lennujaam/hotel/hotelli_hind"/>
							</span>
						</li>

						<li>
							<span class="yellow">
								Muud kulud: <xsl:value-of select="lennujaam/hotel/muud_kulud"/>
							</span>
						</li>

						<li>
							<xsl:text>Lahkumise riik: </xsl:text>
							<xsl:value-of select="lennujaam/riigid/lahkumine"/>
						</li>

						<li>
							<xsl:text>Saabumise riik: </xsl:text>
							<xsl:value-of select="lennujaam/riigid/saabumine"/>
						</li>

						<li>
							<xsl:variable name="kokku"
                                select="number(lennujaam/hotel/lennu_hind) +
                                        number(lennujaam/hotel/hotelli_hind) +
                                        number(lennujaam/hotel/muud_kulud)"/>
							<xsl:choose>
								<xsl:when test="$kokku &gt; 3000">
									<span class="expensive">
										Koguhind: <xsl:value-of select="format-number($kokku,'0.00')"/>
									</span>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>Koguhind: </xsl:text>
									<xsl:value-of select="format-number($kokku,'0.00')"/>
								</xsl:otherwise>
							</xsl:choose>
						</li>
					</ul>
				</xsl:for-each>

				<h2>Kõik andmed tabelina</h2>

				<table>
					<tr>
						<th>Lennujaam</th>
						<th>Kood</th>
						<th>Hotell</th>
						<th>Tärnid</th>
						<th>Transport</th>
						<th>Lennu hind</th>
						<th>Hotelli hind</th>
						<th>Muud kulud</th>
						<th>Koguhind</th>
						<th>Lahkumine</th>
						<th>Saabumine</th>
					</tr>

					<xsl:for-each select="reis">
						<xsl:variable name="sum"
                            select="number(lennujaam/hotel/lennu_hind) +
                                    number(lennujaam/hotel/hotelli_hind) +
                                    number(lennujaam/hotel/muud_kulud)"/>
						<tr>
							<td>
								<xsl:value-of select="lennujaam/@nimi"/>
							</td>
							<td>
								<xsl:value-of select="lennujaam/@kood"/>
							</td>
							<td>
								<xsl:choose>
									<xsl:when test="lennujaam/hotel/@tarnid = 5">
										<span class="expensive">
											<xsl:value-of select="lennujaam/hotel/@hotellnimi"/>
										</span>
									</xsl:when>
									<xsl:otherwise>
										<xsl:value-of select="lennujaam/hotel/@hotellnimi"/>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
								<xsl:value-of select="lennujaam/hotel/@tarnid"/>
							</td>
							<td>
								<xsl:value-of select="lennujaam/hotel/transport"/>
							</td>
							<td>
								<xsl:value-of select="lennujaam/hotel/lennu_hind"/>
							</td>
							<td>
								<xsl:value-of select="lennujaam/hotel/hotelli_hind"/>
							</td>
							<td>
								<xsl:value-of select="lennujaam/hotel/muud_kulud"/>
							</td>
							<td>
								<xsl:value-of select="format-number($sum,'0.00')"/>
							</td>
							<td>
								<xsl:value-of select="lennujaam/riigid/lahkumine"/>
							</td>
							<td>
								<xsl:value-of select="lennujaam/riigid/saabumine"/>
							</td>
						</tr>
					</xsl:for-each>
				</table>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
