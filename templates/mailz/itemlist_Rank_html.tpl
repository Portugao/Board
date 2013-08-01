{* Purpose of this template: Display ranks in html mailings *}
{*
<ul>
{foreach item='item' from=$items}
    <li>
        <a href="{modurl modname='MUBoard' type='user' func='display' ot=$objectType id=$item.id fqurl=true}
">{$item.name}
</a>
    </li>
{foreachelse}
    <li>{gt text='No ranks found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_Rank_display_description.tpl'}
