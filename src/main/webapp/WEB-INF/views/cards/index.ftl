<#function max x y>
    <#if (x<y)><#return y><#else><#return x></#if>
</#function>
<#function min x y>
    <#if (x<y)><#return x><#else><#return y></#if>
</#function>
<#macro pages totalPages p>
    <#assign size = totalPages?size>
    <#if (p<=4)> <#-- p among first 5 pages -->
        <#assign interval = 1..(min(5,size))>
    <#elseif ((size-p)<4)> <#-- p among last 5 pages -->
        <#assign interval = (max(1,(size-4)))..size >
    <#else>
        <#assign interval = (p-2)..(p+2)>
    </#if>
    <#if !(interval?seq_contains(1))>
     <a href="cards?curPage=1">1</a> ... <#rt>
    </#if>
    <#list interval as page>
        <#if page=p>
         <${page}> <#t>
        <#else>
         <a href="cards?curPage=${page}">${page}</a> <#t>
        </#if>
    </#list>
    <#if !(interval?seq_contains(size))>
     ... <a href="cards?curPage=${size}">${size}</a><#lt>
    </#if>
</#macro>

<@content for="title">Cards List</@content>


<div class="message"><@flash name="message"/></div>



<@link_to action="new_form">Add new card</@link_to>

<div><@pages 1..totalPages currentPage /></div>
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
            ${card.basecard.rules_text!""}
        </td>
    </tr>
</#list>
</table>




