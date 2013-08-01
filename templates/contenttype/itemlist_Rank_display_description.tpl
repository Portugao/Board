{* Purpose of this template: Display ranks within an external context *}

<dl>
{foreach item='item' from=$items}
    <dt>{$item.name}</dt>
    <dd><a href="{modurl modname='MUBoard' type='user' func='display' ot=$objectType id=$item.id}">{gt text='Read more'}</a></dd>
{foreachelse}
    <dt>{gt text='No entries found.'}</dt>
{/foreach}
</dl>
