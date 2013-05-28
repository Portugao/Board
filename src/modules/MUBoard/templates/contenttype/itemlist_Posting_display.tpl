{* Purpose of this template: Display postings within an external context *}

<dl>
{foreach item='item' from=$items}
{if $item.createdUserId eq 0 || $item.createdUserId eq 1}
{gt text='Guest' assign='itemuser'}
{else}
{usergetvar name='uname' uid=$item.createdUserId assign='itemuser'}
{/if}
{if $item.parent_id eq NULL}
    <h6>{$itemuser} {gt text='opened issue:'} {$item.title} | {$item.createdDate|dateformat:datebrief}</h6>
{else}
    <h6>{$itemuser} {gt text='answered to issue:'} {$item.parent.title} | {$item.createdDate|dateformat:datebrief}</h6>
{/if}
    {if $item.parent_id eq NULL}
    <dd><a href="{modurl modname='MUBoard' type='user' func='display' ot=$objectType id=$item.id}">{gt text='Read more'}</a></dd>
    {else}
        <dd><a href="{modurl modname='MUBoard' type='user' func='display' ot=$objectType id=$item.parent_id}/#{$item.id}">{gt text='Read more'}</a></dd>
    {/if}
{foreachelse}
    <dt>{gt text='No entries found.'}</dt>
{/foreach}
</dl>
