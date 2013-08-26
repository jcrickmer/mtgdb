<@content for="title">Add new expansion set</@content>

<span class="error_message"><@flash name="message"/></span>
<h2>Adding new expansion set</h2>


<@form action="create" method="post">
    <table style="margin:30px">
        <tr>
            <td>Expansion set</td>
            <td><input type="text" name="name" value="${(flasher.params.name)!}"> *
                            <span class="error">${(flasher.errors.name)!}</span>
            </td>
        </tr>
        <tr>
            <td>Abbreviation</td>
            <td><input type="text" name="abbr" value="${(flasher.params.abbr)!}"> *
                            <span class="error">${(flasher.errors.abbr)!}</span>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><@link_to>Cancel</@link_to> | <input type="submit" value="Add new expansion set"></td>
        </tr>
    </table>
</@form>
