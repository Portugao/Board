{include file='user/header.tpl'}
<h2>{gt text ='Your Result!'}</h2>
{if $message ne ''}
{$message}
{else}
{foreach item='issue' from=$entities}
<a href="{modurl modname='MUBoard' type='user' func='display' ot='posting' id=$issue.id}">{$issue.title}</a> ( <a href="{modurl modname='MUBoard' type='user' func='display' ot='forum' id=$issue.forum.id}">{$issue.forum.title}</a> )<br /> 
{/foreach}
{/if}

