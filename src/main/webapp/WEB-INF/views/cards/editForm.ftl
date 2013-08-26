<@content for="title">Edit Card - ${card.basecard.name}</@content>
<script type="text/javascript"> 
$("<link/>", {
   rel: "stylesheet",
   type: "text/css",
   href: "${context_path}/css/new_card.css"
}).appendTo("head");
$("<link/>", {
   rel: "stylesheet",
   type: "text/css",
   href: "${context_path}/js/autosuggest/autoSuggest.css"
}).appendTo("head");
</script>
<script type="text/javascript" src="${context_path}/js/autosuggest/jquery.autoSuggest.js"></script>
<span class="error_message"><@flash name="message"/></span>
<h2>Edit Card - ${card.basecard.name}</h2>

<@form action="editCard" method="post">
  <input type="hidden" name="multiverseid" value="${card.multiverseid!}" />
  <div id="basecard">
    <table style="margin:30px">
      <tr>
        <td>Name</td>
        <td>
          ${card.basecard.name}
          <script type="text/javascript">
var typesData = {items: [
<#list types as type>
{value: "${type.id}", name: "${type.type}"},
</#list>
]}; 
var subtypesData = {items: [
<#list subtypes as subtype>
{value: "${subtype.id}", name: "${subtype.subtype}"},
</#list>
]};

$("#basecard_id").hide();
function nameLookupCB(request, response) {
    //console.log("request is " + request.term);
    $.ajax({
            type: "POST",
            url: "<@controller_link controller="cards" action="nameLookup" />",
            data: { namePartial: request.term, limit: 15 },
            dataType: "json",
            success: function(data, textStatus, jqXHR) {
                //console.log("response is " + response);
                //console.log("status: " + textStatus);
                //console.dir(data);
                response(data.terms);
            }
    });
}

/** Returns an array of strings */
function parseManaCost(mana_cost) {
    var parts = mana_cost.replace(/{/g,"").split("}");
    var results = new Array();
    for (var t = 0; t < parts.length; t++) {
        if (parts[t].length > 0) {
	      results.push(parts[t].toUpperCase());
        }
    }
    return results;
}

function parseManaCostToElement(mana_cost, elementSelector) {
    var symbols = parseManaCost(mana_cost);
    for (var y = 0; y < symbols.length; y++) {
        $("<img/>", {
                     alt: symbols[y],
                     src: "${context_path}/images/symbols/symbol_mana_" + symbols[y] + "_small.gif"
                    }).appendTo(elementSelector);
    }
    return symbols;
}

function lockInBaseCard(baseCard) {
$("#basecard_id").val(baseCard.id); 
console.dir(baseCard);
    $("#rules_text").text(baseCard.rules_text);
    $("#rules_text").attr("disabled", "disabled");
    $("#cmc").text(baseCard.cmc);
    $("#color").html("");
    var ccc = "";
    for (var h = 0; h < baseCard.color.length; h++ ) {
        if (h > 0) { ccc = ccc.concat(", "); }
        ccc = ccc.concat(baseCard.color[h]); 
    }
    $("#color").html(ccc);
    $("#mana_cost").html("");
    parseManaCostToElement(baseCard.mana_cost, "#mana_cost");
    $("#mana_cost_f").hide();
    $("#mana_cost_f").val(baseCard.mana_cost);
    $("#mana_cost_fr").hide();

    $("#power").val(baseCard.power);
    $("#power").attr("disabled", "disabled");
    $("#toughness").val(baseCard.toughness);
    $("#toughness").attr("disabled", "disabled");
    $("#loyalty").val(baseCard.loyalty);
    $("#loyalty").attr("disabled", "disabled");

    var typePreFill = [];
    for (var q = 0; q < baseCard.type.length; q++) {
        typePreFill.push({value: q, name: baseCard.type[q]});
    }
    $("#as_type_hard").html(baseCard.type.join(" "));
    $("#as_type_node").parent().parent().hide();
    $("#as_subtype_hard").html(baseCard.subtype.join(" "));
    $("#as_subtype_node").parent().parent().hide();
}

function unlockBaseCard() {
    $("#basecard_id").val("");
    $("#rules_text").removeAttr("disabled");
    $("#cmc").html("<i>to be calculated</i>");
    $("#color").html("<i>to be calculated</i>");

    $("#mana_cost").html("");
    $("#mana_cost").show();
    $("#mana_cost_f").show();
    $("#mana_cost_fr").show();

    $("#power").removeAttr("disabled");
    $("#toughness").removeAttr("disabled");
    $("#loyalty").removeAttr("disabled");

    $("#as_type_hard").html("");
    $("#as_type_node").parent().parent().show(); // REVISIT - this part sucks.  We need to find a way to keep the type and subtype values between state changes
    $("#as_subtype_hard").html("");
    $("#as_subtype_node").parent().parent().show(); // REVISIT - this part sucks.  We need to find a way to keep the type and subtype values between state changes
}

function nameBlurred(event, ui) {
    //console.log("Moving on..." + $("#name_field").val());
    $.ajax({
        type: "POST",
        url: "<@controller_link controller="cards" action="getBaseCardByName" />",
        data: { name: $("#name_field").val()},
        dataType: "json",
        success: function(data, textStatus, jqXHR) {
            console.log("nameBlurred status: " + textStatus);
            console.dir(data);
            if (data != null && data.BaseCard != null) {
                lockInBaseCard(data.BaseCard);
            } else {
                unlockBaseCard();
            }
        }
    });
}

$("#name_field").autocomplete({ delay: 500, minLength: 3, source: nameLookupCB, change: nameBlurred});
          </script>
        </td>
      </tr>
      <tr>
        <td>Rules Text</td>
        <td>
          ${card.basecard.rules_text!""}
        </td>
      </tr>
      <tr>
        <td>Mana Cost</td>
        <td>
          ${card.basecard.mana_cost}
        </td>
      </tr>
      <tr>
        <td>Converted Mana Cost</td>
        <td>
          ${card.basecard.cmc}
        </td>
      </tr>
      <tr>
        <td>Color</td>
        <td>
          <#list card.basecard.colors as ccc>${ccc.color} </#list>
        </td>
      </tr>
      <tr>
        <td>Type</td>
        <td>
          <#list card.basecard.orderedTypes() as ttt>${ttt} </#list>
      </tr>
      <tr>
        <td>Subtype</td>
        <td>
          <#if (card.basecard.orderedSubtypes()?size > 0)>
            <#list card.basecard.orderedSubtypes() as sss>${sss} </#list>
          </#if>
        </td>
      </tr>
      <tr>
        <td>Power</td>
        <td>
          ${card.basecard.power!""}
        </td>
      </tr>
      <tr>
        <td>Toughness</td>
        <td>
          ${card.basecard.toughness!""}
        </td>
      </tr>
      <tr>
        <td>Loyalty</td>
        <td>
          ${card.basecard.loyalty!""}
        </td>
      </tr>
    </table>
  </div>
  <div id="card_input">
    <table style="margin:30px">
      <tr>
        <td>Multiverse Id</td>
        <td><input type="text" name="multiverseid_changed" value="${card.multiverseid!}"> *
                            <span class="error">${(flasher.errors.multiverseid)!}</span>
        </td>
      </tr>
      <tr>
        <td>Expansion Set</td>
        <td>
          <select name="expansionset_id" id="expansionset_id">
            <#list expansionsets as expset>
              <option value="${expset.id}">${expset.name}</option>
            </#list>
          </select>
          <script>
$("#expansionset_id").val("${card.expansionset_id!""}");
          </script>
          *
          <span class="error">${(flasher.errors.expansionset_id)!}</span>
        </td>
      </tr>
      <tr>
        <td>Card Number</td>
        <td><input type="text" name="card_number" value="${card.card_number!}"> *
                            <span class="error">${(flasher.errors.card_number)!}</span>
        </td>
      </tr>
      <tr>
        <td>Rarity</td>
        <td>
          <select id="rarity_id" name="rarity_id">
            <#list rarities as rarity>
              <option value="${rarity.id}">${rarity.rarity}</option>
            </#list>
          </select>
          <script>
$("#rarity_id").val("${card.rarity}");
          </script>
          *
          <span class="error">${(flasher.errors.rarity_id)!}</span>
        </td>
      </tr>
      <tr>
        <td>Flavor Text</td>
        <td>
          <textarea rows="5" cols="80" name="flavor_text">${card.flavor_text!}</textarea>
          <span class="error">${(flasher.errors.flavor_text)!}</span>
        </td>
      </tr>
    </table>
  </div>
  <div>
    <table>
      <tr>
        <td></td>
        <td><@link_to>Cancel</@link_to> | <input type="submit" value="Save"></td>
      </tr>
    </table>
  </div>
</@form>
