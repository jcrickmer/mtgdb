<@content for="title">Cards List</@content>


<div class="message"><@flash name="message"/></div>



<@link_to action="new_form">Add new card</@link_to>

<table>
    <tr>
        <td>Name</td>
        <td>Rules Text</td>
        <td>Edit</td>
    </tr>
<#list cards as card>
    <tr>
        <td>
            <@link_to action="show" id=card.id>${card.name}</@link_to>
        </td>
        <td>
            ${card.rules_text}</td>
        <td>
            <@confirm text="Are you sure you want to delete this card: " + card.name + "?" form=card.id>Delete</@confirm>
            <@form  id=card.id action="delete" method="delete" html_id=card.id />
        </td>
    </tr>
</#list>
</table>




