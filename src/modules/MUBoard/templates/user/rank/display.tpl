{* purpose of this template: ranks display view in user area *}
{include file='user/header.tpl'}
<div class="muboard-rank muboard-display">
{gt text='Rank' assign='templateTitle'}
{assign var='templateTitle' value=$rank.name|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-frontendcontainer">
    <h2>{$templateTitle|notifyfilters:'muboard.filter_hooks.ranks.filter'}</h2>


<dl id="MUBoard_body">
    <dt>{gt text='Min postings'}</dt>
    <dd>{$rank.minPostings}</dd>
    <dt>{gt text='Max postings'}</dt>
    <dd>{$rank.maxPostings}</dd>
    <dt>{gt text='Number of icons'}</dt>
    <dd>{$rank.numberOfIcons}</dd>
    <dt>{gt text='Upload image'}</dt>
    <dd>  <a href="{$rank.uploadImageFullPathURL}" title="{$rank.name|replace:"\"":""}"{if $rank.uploadImageMeta.isImage} rel="imageviewer[rank]"{/if}>
  {if $rank.uploadImageMeta.isImage}
      <img src="{$rank.uploadImage|muboardImageThumb:$rank.uploadImageFullPath:250:150}" width="250" height="150" alt="{$rank.name|replace:"\"":""}" />
  {else}
      {gt text='Download'} ({$rank.uploadImageMeta.size|muboardGetFileSize:$rank.uploadImageFullPath:false:false})
  {/if}
  </a>
</dd>
    <dt>{gt text='Special'}</dt>
    <dd>{$rank.special|yesno:true}</dd>
</dl>
    {include file='user/include_standardfields_display.tpl' obj=$rank}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
{if count($rank._actions) gt 0}
    <p>{strip}
    {foreach item='option' from=$rank._actions}
        <a href="{$option.url.type|muboardActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">
            {$option.linkText|safetext}
        </a>
    {/foreach}
    {/strip}</p>
{/if}

{* include display hooks *}
{notifydisplayhooks eventname='muboard.ui_hooks.ranks.display_view' id=$rank.id urlobject=$currentUrlObject assign='hooks'}
{foreach key='hookname' item='hook' from=$hooks}
    {$hook}
{/foreach}

{/if}

</div>
</div>
{include file='user/footer.tpl'}

