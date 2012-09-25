{* Purpose of this template: Display ranks within an external context *}

{foreach item='item' from=$items}
    <h3>{$item.name}</h3>
    <p><a href="{modurl modname='MUBoard' type='user' func='display' ot=$objectType id=$item.id}">{gt text='Read more'}</a></p>
{/foreach}
