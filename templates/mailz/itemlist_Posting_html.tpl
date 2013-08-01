{* Purpose of this template: Display postings in html mailings *}
{*
<ul>
{foreach item='item' from=$items}
    <li>
        <a href="{modurl modname='MUBoard' type='user' func='display' ot=$objectType id=$item.id fqurl=true}
">{$item.title}
</a>
    </li>
{foreachelse}
    <li>{gt text='No postings found.'}</li>
{/foreach}
</ul>
*}

{include file='contenttype/itemlist_Posting_display_description.tpl'}
