 <@content for="title">Expansion Sets List</@content>


<div class="message"><@flash name="message"/></div>



<@link_to action="new_form">Add new expansion set</@link_to>

<table>
    <tr>
        <td>Id</td>
        <td>Name</td>
        <td></td>
    </tr>
<#list expansionsets as xset>
    <tr>
        <td>
            <@link_to action="show" id=xset.id>${xset.id}</@link_to>
        </td>
        <td>
            <@link_to action="show" id=xset.id>${xset.name}</@link_to>
        </td>
        <td>
            <@confirm text="Are you sure you want to delete this expansion set: " + xset.name + "?" form=xset.id>Delete</@confirm>
            <@form id=xset.id action="delete" method="delete" html_id=xset.id />
        </td>
    </tr>
</#list>
</table>
