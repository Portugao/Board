{* Purpose of this template: Display ranks in text mailings *}
{foreach item='item' from=$items}
        {$item.name}
        {modurl modname='MUBoard' type='user' func='display' ot=$objectType id=$item.id fqurl=true}
-----
{foreachelse}
    {gt text='No ranks found.'}
{/foreach}
