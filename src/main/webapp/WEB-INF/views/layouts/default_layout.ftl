<#setting url_escaping_charset='ISO-8859-1'>

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="${context_path}/css/main.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
<!--
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
 -->
    <script src="${context_path}/js/jquery-ui-1.10.3.custom/js/jquery-1.9.1.js" type="text/javascript"></script>
    <script src="${context_path}/js/jquery-ui-1.10.3.custom/js/jquery-ui-1.10.3.custom.js" type="text/javascript"></script>
    <script src="${context_path}/js/aw.js" type="text/javascript"></script>
    <title>MTGDB - <@yield to="title"/></title>
  </head>
  <body>

    <div class="main">
      <#include "header.ftl" >
      <div class="content">
        ${page_content}
      </div>
      <#include "footer.ftl" >
    </div>
  </body>
</html>
