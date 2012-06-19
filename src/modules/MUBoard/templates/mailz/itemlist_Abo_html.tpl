{* Purpose of this template: Display abos in html mailings *}
{*
<ul>
{foreach item='item' from=$items}
    <li>
        <a href="{modurl modname='MUBoard' type='user' func='display' ot=$objectType id=$item.id fqurl=true}
">{$item.userid}
</a>
    </li>
{foreachelse}
    <li>{gt text='No abos found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_Abo_display_description.tpl'}
