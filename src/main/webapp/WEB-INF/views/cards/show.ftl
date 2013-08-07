<@content for="title">Card: ${card.basecard.name}</@content>

  <div class="site_nav_area">
    <@link_to controller="cards" action="displaySearchResults">Back to cards list</@link_to>
  </div>

  <h2>${card.basecard.name}</h2>
  <script type="text/javascript">
var card = {
  basecard:{
    name:"${card.basecard.name}",
    /* rules_text:"${card.basecard.rules_text!""}", // REVISIT - need to escape quotes */
    mana_cost:"${card.basecard.mana_cost}",
  },
  multiverseid: ${card.multiverseid},
  /* flavor_text:"${card.flavor_text!""}" // REVISIT - need to escape quotes */
};
  </script>
  <div class="card_image_display">
    <#if card.multiverseid < 1000000 >
      <img src="http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=${card.multiverseid}&type=card">
    </#if>
    <#if (card.multiverseid >= 1000000) >
      <img src="/mtgdb/cardImage?multiverseid=${card.multiverseid}">
    </#if>
  </div>
  <div class="card_info_display">
    <table>
      <tr class="card_info_line"><td class="card_info_title">Name</td><td class="card_info_value">${card.basecard.name}</td></tr>
      <tr class="card_info_line"><td class="card_info_title">Mana Cost</td><td class="card_info_value" id="card_info_value_mana_cost">${card.basecard.mana_cost}</td></tr>
      <tr class="card_info_line"><td class="card_info_title">Color(s)</td><td class="card_info_value"><#list card.basecard.colors as ccc>${ccc.color} </#list></td></tr>
      <tr class="card_info_line"><td class="card_info_title">Type</td><td class="card_info_value"><#list card.basecard.orderedTypes() as ttt>${ttt} </#list></td></tr>
    <#if (card.basecard.orderedSubtypes()?size > 0)>
        <tr class="card_info_line"><td class="card_info_title">Subtype</td><td class="card_info_value"><#list card.basecard.orderedSubtypes() as sss>${sss} </#list></td></tr>
    </#if>
      <tr class="card_info_line"><td class="card_info_title">Rules</td><td class="card_info_value" id="card_info_value_rules">${card.basecard.rules_text!""}</td></tr>
<script>
var rules = $("#card_info_value_rules").html();
var re = /\n/g;
var newstr = rules.replace(re, "<br/>\n");
console.log("newstr - " + newstr);
function replaceSymbols(match, capture) {
    //console.log("match - " + match);
    //console.log("capture - " + capture);
    var fname = "/mtgdb/images/symbols/";
    if (capture == "t") {
        fname += "symbol_tap_small.gif";
    } else {
        fname += "symbol_mana_" + capture + "_small.gif";
    }
    return "<img src=\"" + fname + "\" alt=\""+match+"\"/>";
}
var newnew = newstr.replace(/\{([^\}]+)\}/g, replaceSymbols);
$("#card_info_value_rules").html(newnew);
</script>
      <tr class="card_info_line"><td class="card_info_title">CMC</td><td class="card_info_value">${card.basecard.cmc}</td></tr>
      <#if card.basecard.orderedTypes()?seq_contains("Creature")>
        <tr class="card_info_line"><td class="card_info_title">Power</td><td class="card_info_value">${card.basecard.power!""}</td></tr>
        <tr class="card_info_line"><td class="card_info_title">Toughness</td><td class="card_info_value">${card.basecard.toughness!""}</td></tr>
      </#if>
      <#if card.basecard.orderedTypes()?seq_contains("Planeswalker")>
        <tr class="card_info_line"><td class="card_info_title">Loyalty</td><td class="card_info_value">${card.basecard.loyalty!""}</td></tr>
      </#if>
      <tr class="card_info_line"><td class="card_info_title">Flavor</td><td class="card_info_value">${card.flavor_text!""}</td></tr>
      <tr class="card_info_line"><td class="card_info_title">Multiverse Id</td><td class="card_info_value">${card.multiverseid}</td></tr>
      <tr class="card_info_line"><td class="card_info_title">Expansion Set</td><td class="card_info_value">${card.expansionset.name}</td></tr>
      <tr class="card_info_line"><td class="card_info_title">Card Number</td><td class="card_info_value">${card.card_number!""}</td></tr>
<script>
var cost_a = card.basecard.mana_cost.split("}");
var imgs = "";
for (var q = 0; q < cost_a.length; q++) {
    var curCost = cost_a[q];
    if (curCost.toString().indexOf("{") == 0) {
        var symb = curCost.toString().substring(1, curCost.length);
        var surl = "/mtgdb/images/symbols/symbol_mana_" + symb + "_small.gif";
        imgs += "<img src=\"" + surl + "\" alt=\"{"+symb+"}\"/>";
    }
}
$("#card_info_value_mana_cost").html(imgs);
</script>
    </table>
  </div>

<div><a href="#" id="button_edit_card">Edit Card</a></div>
<script>
$("#button_edit_card").button()
                      .click(function( event ) {
    event.preventDefault();
});
</script>
