{* Purpose of this template: Display categories in text mailings *}
{foreach item='item' from=$items}
        {$item.title}
        {modurl modname='MUBoard' type='user' func='display' ot=$objectType id=$item.id fqurl=true}
-----
{foreachelse}
    {gt text='No categories found.'}
{/foreach}
