<@content for="title">Cards List</@content>


<div class="message"><@flash name="message"/></div>



<@link_to action="new_form">Add new card</@link_to>

<table>
    <tr>
        <td>Name</td>
        <td>Rules Text</td>
    </tr>
<#list cards as card>
    <tr>
        <td>
            <@link_to action="show" id=card.multiverseid>${card.basecard.name}</@link_to>
        </td>
        <td>
            ${card.basecard.rules_text}
        </td>
    </tr>
</#list>
</table>




