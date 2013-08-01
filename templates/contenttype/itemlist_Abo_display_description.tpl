{* Purpose of this template: Display abos within an external context *}

<dl>
{foreach item='item' from=$items}
    <dt>{$item.userid}</dt>
    <dd><a href="{modurl modname='MUBoard' type='user' func='display' ot=$objectType id=$item.id}">{gt text='Read more'}</a></dd>
{foreachelse}
    <dt>{gt text='No entries found.'}</dt>
{/foreach}
</dl>
