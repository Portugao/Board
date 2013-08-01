{* purpose of this template: inclusion template for display of related Postings in admin area *}

{if isset($items) && $items ne null}
<ul class="relatedItemList Posting">
{foreach name='relLoop' item='item' from=$items}
    <li>
    <a href="{modurl modname='MUBoard' type='admin' func='display' ot='posting' id=$item.id}">
        {$item.title}
    </a>
    <a id="postingItem{$item.id}Display" href="{modurl modname='MUBoard' type='admin' func='display' ot='posting' id=$item.id theme='Printer'}" title="{gt text='Open quick view window'}" style="display: none">
        {icon type='view' size='extrasmall' __alt='Quick view'}
    </a>
    <script type="text/javascript" charset="utf-8">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            muboardInitInlineWindow($('postingItem{{$item.id}}Display'), '{{$item.title|replace:"'":""}}');
        });
    /* ]]> */
    </script>
    <br />
{if $item.firstImage ne '' && isset($item.firstImageFullPathURL)}
    <img src="{$item.firstImage|muboardImageThumb:$item.firstImageFullPathURL:50:40}" width="50" height="40" alt="{$item.title|replace:"\"":""}" />
{/if}

    </li>
{/foreach}
</ul>
{/if}

