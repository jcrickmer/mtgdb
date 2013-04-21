<@content for="title">Add new card</@content>

<span class="error_message"><@flash name="message"/></span>
<h2>Adding new card</h2>


<@form action="create" method="post">
    <table style="margin:30px">
        <tr>
            <td>Name:</td>
            <td><input type="text" name="name" value="${(flasher.params.name)!}"> *
                            <span class="error">${(flasher.errors.name)!}</span>
            </td>
        </tr>
        <tr>
            <td>Rules Text</td>
            <td><input type="text" name="rules_text" value="${(flasher.params.rules_text)!}"> *
                            <span class="error">${(flasher.errors.rules_text)!}</span>
            </td>
        </tr>
        <tr>
            <td></td>
            <td><@link_to>Cancel</@link_to> | <input type="submit" value="Add new card"></td>

        </tr>
    </table>
</@form>



