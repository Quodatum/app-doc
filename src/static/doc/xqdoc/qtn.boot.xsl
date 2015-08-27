<!-- A 'bootstrap' XSLT 1.0 stylesheet to load any
 Saxon-CE XSLT 2.0 stylesheet - 'sample.xsl' in this case.
 The first<script> element 'src' attribute is set to the Saxonce loaction
-->
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
version="1.0">
<xsl:output method="html" indent="no"/>
<xsl:template match="/"> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" />
http://localhost:8984/static/lib/saxonce/1.1/Saxonce/Saxonce.nocache.js
<script type="text/javascript" language="javascript" src="../../lib/saxonce/1.1/Saxonce/Saxonce.nocache.js"></script>
<script>
var onSaxonLoad = function() {
    Saxon.run( {
         source:     location.href,
         logLevel:   "SEVERE",
         stylesheet: "html-module.xsl"
    });
}
</script>
</head>
<!-- these elements are required: -->
<body><p></p></body>
</html>    
</xsl:template>
</xsl:transform>	
