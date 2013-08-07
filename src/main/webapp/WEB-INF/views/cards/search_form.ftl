<@content for="title">Search Cards</@content>
<script type="text/javascript"> 
$("<link/>", {
   rel: "stylesheet",
   type: "text/css",
   href: "${context_path}/css/search_form.css"
}).appendTo("head");
$("<link/>", {
   rel: "stylesheet",
   type: "text/css",
   href: "${context_path}/js/autosuggest/autoSuggest.css"
}).appendTo("head");
</script>
<script type="text/javascript" src="${context_path}/js/autosuggest/jquery.autoSuggest.js"></script>
<span class="error_message"><@flash name="message"/></span>
<h2>Search Cards</h2>

<@form action="search" method="post">
  <div id="basecard_input">
    <table style="margin:30px">
      <tr>
        <td>Name</td>
        <td>
          <input type="text" id="name" name="name" value="">
        </td>
      </tr>
      <tr><td colspan="2"><input type="submit"/></td></tr>
    </table>
  </div>
</@form>
