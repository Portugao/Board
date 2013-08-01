{* Purpose of this template: Display users in html mailings *}
{*
<ul>
{foreach item='item' from=$items}
    <li>
        <a href="{modurl modname='MUBoard' type='user' func='display' ot=$objectType id=$item.id fqurl=true}
">{$item.userid}
</a>
    </li>
{foreachelse}
    <li>{gt text='No users found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_User_display_description.tpl'}
