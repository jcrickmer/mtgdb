<@content for="title">Add new card</@content>
<script type="text/javascript">
$("<link/>", {
   rel: "stylesheet",
   type: "text/css",
   href: "${context_path}/css/new_card.css"
}).appendTo("head");
</script>
<span class="error_message"><@flash name="message"/></span>
<h2>Adding new card</h2>


<@form action="create" method="post">
  <div id="basecard_input">
    <table style="margin:30px">
      <tr>
        <td>Name</td>
        <td>
          <input type="text" id="name_field" name="name" value="${(flasher.params.name)!}">
          *
          <span class="error">${(flasher.errors.name)!}</span>
          <script type="text/javascript">
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

function nameBlurred(event, ui) {
    //console.log("Moving on..." + $("#name_field").val());
    $.ajax({
        type: "POST",
        url: "<@controller_link controller="cards" action="getBaseCardByName" />",
        data: { name: $("#name_field").val()},
        dataType: "json",
        success: function(data, textStatus, jqXHR) {
            //console.log("nameBlurred status: " + textStatus);
            //console.dir(data);
            $("#rules_text").text(data.BaseCard.rules_text);
            $("#rules_text").attr("disabled", "disabled");
            $("#cmc").text(data.BaseCard.cmc);
            $("#cmc").attr("disabled", "disabled");
            $("#color").html("");
            var ccc = "";
            for (var h = 0; h < data.BaseCard.color.length; h++ ) {
                if (h > 0) { ccc = ccc.concat(", "); }
                ccc = ccc.concat(data.BaseCard.color[h].color); 
            }
            $("#color").html(ccc);
            $("#mana_cost").html("");
            parseManaCostToElement(data.BaseCard.mana_cost, "#mana_cost");
            $("#mana_cost_f").hide();
            $("#mana_cost_fr").hide();

            $("#power").val(data.BaseCard.power);
            $("#power").attr("disabled", "disabled");
            $("#toughness").val(data.BaseCard.toughness);
            $("#toughness").attr("disabled", "disabled");
            $("#loyalty").val(data.BaseCard.loyalty);
            $("#loyalty").attr("disabled", "disabled");
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
          <textarea id="rules_text" name="rules_text">${(flasher.params.rules_text)!}</textarea>
          <span class="error">${(flasher.errors.rules_text)!}</span>
        </td>
      </tr>
      <tr>
        <td>Mana Cost</td>
        <td>
          <span id="mana_cost"></span><input type="text" id="mana_cost_f" name="mana_cost" value="${(flasher.params.mana_cost)!}">
          <span id="mana_cost_fr">*</span>
          <span class="error">${(flasher.errors.mana_cost)!}</span>
        </td>
      </tr>
      <tr>
        <td>Converted Mana Cost</td>
        <td>
          <span id="cmc"><i>to be calculated</i></span>
        </td>
      </tr>
      <tr>
        <td>Color</td>
        <td>
          <span id="color"><i>to be calculated</i></span>
        </td>
      </tr>
      <tr>
        <td>Type</td>
        <td>
          <@select id="type" name="type_id" list=typesList>
	    <option value=""></option>
          </@>
          *
          <span class="error">${(flasher.errors.type_id)!}</span>
        </td>
      </tr>
      <tr>
        <td>Subtype</td>
        <td>
          <select name="subtype_id">
	    <option value=""></option>
            <#list subtypes as subtype>
              <option value="${subtype.id}">${subtype.subtype}</option>
            </#list>
          </select>
          <span class="error">${(flasher.errors.subtype_id)!}</span>
        </td>
      </tr>
      <tr>
        <td>Power</td>
        <td>
          <input type="text" id="power" name="power" value="${(flasher.params.power)!}">
          <span class="error">${(flasher.errors.power)!}</span>
        </td>
      </tr>
      <tr>
        <td>Toughness</td>
        <td>
          <input type="text" id="toughness" name="toughness" value="${(flasher.params.toughness)!}">
          <span class="error">${(flasher.errors.toughness)!}</span>
        </td>
      </tr>
      <tr>
        <td>Loyalty</td>
        <td>
          <input type="text" id="loyalty" name="loyalty" value="${(flasher.params.loyalty)!}">
          <span class="error">${(flasher.errors.loyalty)!}</span>
        </td>
      </tr>
    </table>
  </div>
  <div id="card_input">
    <table style="margin:30px">
      <tr>
        <td>Multiverse Id</td>
        <td><input type="text" name="multiverseid" value="${(flasher.params.multiverseid)!}"> *
                            <span class="error">${(flasher.errors.multiverseid)!}</span>
        </td>
      </tr>
      <tr>
        <td>Expansion Set</td>
        <td>
          <select name="expansionset_id">
            <#list expansionsets as expset>
              <option value="${expset.id}">${expset.name}</option>
            </#list>
          </select>
          *
          <span class="error">${(flasher.errors.expansionset_id)!}</span>
        </td>
      </tr>
      <tr>
        <td>Rarity</td>
        <td>
          <select name="rarity_id">
            <#list rarities as rarity>
              <option value="${rarity.id}">${rarity.rarity}</option>
            </#list>
          </select>
          *
          <span class="error">${(flasher.errors.rarity_id)!}</span>
        </td>
      </tr>
      <tr>
        <td>Flavor Text</td>
        <td>
          <textarea name="flavor_text">${(flasher.params.flavor_text)!}</textarea>
          <span class="error">${(flasher.errors.flavor_text)!}</span>
        </td>
      </tr>
    </table>
  </div>
  <div>
    <table>
      <tr>
        <td></td>
        <td><@link_to>Cancel</@link_to> | <input type="submit" value="Add new card"></td>
      </tr>
    </table>
  </div>
</@form>



