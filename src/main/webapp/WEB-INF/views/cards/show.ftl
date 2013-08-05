<@content for="title">Card: ${card.basecard.name}</@content>

  <div class="site_nav_area">
    <@link_to>Back to all cards</@link_to>
  </div>

  <h2>${card.basecard.name}</h2>
  <script type="text/javascript">
var card = {
  basecard:{
    name:"${card.basecard.name}",
    rules_text:"${card.basecard.rules_text!""}", // REVISIT - need to escape quotes
  },
  multiverseid: ${card.multiverseid},
  flavor_text:"${card.flavor_text!""}" // REVISIT - need to escape quotes
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
    <div class="card_info_line"><span class="card_info_title">Multiverse Id</span><span class="card_info_value">${card.multiverseid}</span></div>
    <div class="card_info_line"><span class="card_info_title">Color(s)</span><span class="card_info_value"><#list card.basecard.colors as ccc>${ccc.color} </#list></span></div>
    <div class="card_info_line"><span class="card_info_title">Type</span><span class="card_info_value"><#list card.basecard.orderedTypes() as ttt>${ttt} </#list></span></div>
    <#if (card.basecard.orderedSubtypes()?size > 0)>
      <div class="card_info_line"><span class="card_info_title">Subtype</span><span class="card_info_value"><#list card.basecard.orderedSubtypes() as sss>${sss} </#list></span></div>
    </#if>
    <div class="card_info_line"><span class="card_info_title">Rules</span><span class="card_info_value">${card.basecard.rules_text!""}</span></div>
    <div class="card_info_line"><span class="card_info_title">Flavor</span><span class="card_info_value">${card.flavor_text!""}</span></div>
    <div class="card_info_line"><span class="card_info_title">Expansion Set</span><span class="card_info_value">${card.expansionset.name}</span></div>
    <div class="card_info_line"><span class="card_info_title">Card Number</span><span class="card_info_value">${card.card_number!""}</span></div>
    <div class="card_info_line"><span class="card_info_title">Mana Cost</span><span class="card_info_value">${card.basecard.mana_cost}</span></div>
    <div class="card_info_line"><span class="card_info_title">CMC</span><span class="card_info_value">${card.basecard.cmc}</span></div>
    <#if card.basecard.orderedTypes()?seq_contains("Creature")>
      <div class="card_info_line"><span class="card_info_title">Power</span><span class="card_info_value">${card.basecard.power!""}</span></div>
      <div class="card_info_line"><span class="card_info_title">Toughness</span><span class="card_info_value">${card.basecard.toughness!""}</span></div>
    </#if>
    <#if card.basecard.orderedTypes()?seq_contains("Planeswalker")>
      <div class="card_info_line"><span class="card_info_title">Loyalty</span><span class="card_info_value">${card.basecard.loyalty!""}</span></div>
    </#if>
  </div>

<pre>
<!--
<#list card.basecard?keys as var>
    ${var}
</#list>
-->
<#if card.basecard.types?is_string>String</#if>
<#if card.basecard.types?is_method>Method</#if>
<#if card.basecard.types?is_hash>Hash</#if>
<#if card.basecard.types?is_hash_ex>Hash Ex</#if>
<#if card.basecard.types?is_sequence>Sequence</#if>
<#if card.basecard.types?is_collection>Collection</#if>
<#if card.basecard.types?is_directive>Directive</#if>
<#if card.basecard.types?is_node>Node</#if>
${card.basecard.cardtypes?first}
${card.basecard.orderedTypes()?first}
</pre>
