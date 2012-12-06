{include file='user/header.tpl'}
<h2>{gt text ='Your Result!'}</h2>
{foreach item='issue' from=$entities}
{if $issue.parent eq NULL}
<a href="{modurl modname='MUBoard' type='user' func='display' ot='posting' id=$issue.id}">{$issue.title}
{/if}
{/foreach}

