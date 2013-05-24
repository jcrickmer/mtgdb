<@content for="title">Add new card</@content>

<span class="error_message"><@flash name="message"/></span>
<h2>Adding new card</h2>


<@form action="create" method="post">
  <div id="basecard_input">
    <table style="margin:30px">
      <tr>
        <td>Name</td>
        <td>
          <input type="text" name="name" value="${(flasher.params.name)!}">
          *
          <span class="error">${(flasher.errors.name)!}</span>
        </td>
      </tr>
      <tr>
        <td>Rules Text</td>
        <td>
          <textarea name="rules_text">${(flasher.params.rules_text)!}</textarea>
          <span class="error">${(flasher.errors.rules_text)!}</span>
        </td>
      </tr>
      <tr>
        <td>Mana Cost</td>
        <td>
          <input type="text" name="mana_cost" value="${(flasher.params.mana_cost)!}">
          *
          <span class="error">${(flasher.errors.mana_cost)!}</span>
        </td>
      </tr>
      <tr>
        <td>Converted Mana Cost</td>
        <td>
          <i>to be calculated</i>
        </td>
      </tr>
      <tr>
        <td>Color</td>
        <td>
          <i>to be calculated</i>
        </td>
      </tr>
      <tr>
        <td>Type</td>
        <td>
          <@select name="type_id" list=typesList>
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
          <input type="text" name="power" value="${(flasher.params.power)!}">
          <span class="error">${(flasher.errors.power)!}</span>
        </td>
      </tr>
      <tr>
        <td>Toughness</td>
        <td>
          <input type="text" name="toughness" value="${(flasher.params.toughness)!}">
          <span class="error">${(flasher.errors.toughness)!}</span>
        </td>
      </tr>
      <tr>
        <td>Loyalty</td>
        <td>
          <input type="text" name="loyalty" value="${(flasher.params.loyalty)!}">
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



