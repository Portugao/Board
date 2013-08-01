{* Purpose of this template: Display users in text mailings *}
{foreach item='item' from=$items}
        {$item.userid}
        {modurl modname='MUBoard' type='user' func='display' ot=$objectType id=$item.id fqurl=true}
-----
{foreachelse}
    {gt text='No users found.'}
{/foreach}
