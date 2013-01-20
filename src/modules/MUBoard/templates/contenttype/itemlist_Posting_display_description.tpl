{* Purpose of this template: Display postings within an external context *}

<dl>
{foreach item='item' from=$items}
{if $item.parent_id eq NULL}
    <h6>{usergetvar name='uname' uid=$createdUserId} {gt text='opened issue:'} {$item.title} | {$item.createdDate|dateformat:datebrief}</h6>
{else}
    <h6>{usergetvar name='uname' uid=$createdUserId} {gt text='answered to issue:'} {$item.parent.title} | {$item.createdDate|dateformat:datebrief}</h6>
{/if}
{if $item.text}
    <dd>{$item.text|notifyfilters:'muboard.filter_hooks.postings.filter'|safehtml|truncate:200:"..."}</dd>
{/if}
    {if $item.parent_id eq NULL}
    <dd><a href="{modurl modname='MUBoard' type='user' func='display' ot=$objectType id=$item.id}">{gt text='Read more'}</a></dd>
    {else}
        <dd><a href="{modurl modname='MUBoard' type='user' func='display' ot=$objectType id=$item.parent_id}">{gt text='Read more'}</a></dd>
    {/if}
{foreachelse}
    <dt>{gt text='No entries found.'}</dt>
{/foreach}
</dl>
