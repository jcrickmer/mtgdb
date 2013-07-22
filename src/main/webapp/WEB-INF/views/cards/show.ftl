<@content for="title">Card: ${card.basecard.name}</@content>
<@link_to>Back to all cards</@link_to>
<h2>${card.basecard.name}</h2>
<#if card.multiverseid < 1000000 >
<img src="http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=${card.multiverseid}&type=card">
</#if>
<#if (card.multiverseid >= 1000000) >
<img src="/mtgdb/cardImage?multiverseid=${card.multiverseid}">
</#if>
<p><strong>Multiverse Id:</strong> ${card.multiverseid}</p>
<p><strong>Color(s):</strong> <#list card.basecard.colors as ccc>${ccc.color} </#list></p>
<p><strong>Type:</strong> <#list card.basecard.types as ttt>${ttt.type} </#list></p>
<p><strong>Subtype:</strong> <#list card.basecard.subtypes as sss>${sss.subtype} </#list></p>
<p><strong>Rules:</strong> ${card.basecard.rules_text!""}</p>
<p><strong>Flavor:</strong> ${card.flavor_text!""}</p>
<p><strong>Expansion Set:</strong> ${card.expansionset.name}</p>
<p><strong>Mana Cost:</strong> ${card.basecard.mana_cost}</p>
<p><strong>CMC:</strong> ${card.basecard.cmc}</p>
<p><strong>Power:</strong> ${card.basecard.power!""}</p>
<p><strong>Toughness:</strong> ${card.basecard.toughness!""}</p>
<p><strong>Loyalty:</strong> ${card.basecard.loyalty!""}</p>
