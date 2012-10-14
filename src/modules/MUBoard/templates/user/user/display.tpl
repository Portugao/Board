{* purpose of this template: users display view in user area *}
{include file='user/header.tpl'}
<div class="muboard-user muboard-display">
{gt text='User' assign='templateTitle'}
{assign var='templateTitle' value=$user.userid|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-frontendcontainer">
    <h2>{$templateTitle|notifyfilters:'muboard.filter_hooks.users.filter'}</h2>


<dl id="MUBoard_body">
    <dt>{gt text='Number postings'}</dt>
    <dd>{$user.numberPostings}</dd>
    <dt>{gt text='Last visit'}</dt>
    <dd>{$user.lastVisit|dateformat:'datetimebrief'}</dd>
    <dt>{gt text='Rank'}</dt>
    <dd>
    {if isset($user.Rank) && $user.Rank ne null}
      {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <a href="{modurl modname='MUBoard' type='user' func='display' ot='rank' id=$user.Rank.id}">
            {$user.Rank.name|default:""}
        </a>
        <a id="rankItem{$user.Rank.id}Display" href="{modurl modname='MUBoard' type='user' func='display' ot='rank' id=$user.Rank.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" style="display: none">
            {icon type='view' size='extrasmall' __alt='Quick view'}
        </a>
        <script type="text/javascript" charset="utf-8">
        /* <![CDATA[ */
            document.observe('dom:loaded', function() {
                muboardInitInlineWindow($('rankItem{{$user.Rank.id}}Display'), '{{$user.Rank.name|replace:"'":""}}');
            });
        /* ]]> */
        </script>
      {else}
        {$user.Rank.name|default:""}
      {/if}
    {else}
        {gt text='No set.'}
    {/if}
    </dd>
</dl>

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
{if count($user._actions) gt 0}
    <p>{strip}
    {foreach item='option' from=$user._actions}
        <a href="{$option.url.type|muboardActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">
            {$option.linkText|safetext}
        </a>
    {/foreach}
    {/strip}</p>
{/if}

{* include display hooks *}
{notifydisplayhooks eventname='muboard.ui_hooks.users.display_view' id=$user.id urlobject=$currentUrlObject assign='hooks'}
{foreach key='hookname' item='hook' from=$hooks}
    {$hook}
{/foreach}

{/if}

</div>
</div>
{include file='user/footer.tpl'}

