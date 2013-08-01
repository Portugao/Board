{* purpose of this template: inclusion template for display of related Abos in admin area *}

{if isset($items) && $items ne null}
<ul class="relatedItemList Abo">
{foreach name='relLoop' item='item' from=$items}
    <li>
    <a href="{modurl modname='MUBoard' type='admin' func='display' ot='abo' id=$item.id}">
        {$item.userid}
    </a>
    <a id="aboItem{$item.id}Display" href="{modurl modname='MUBoard' type='admin' func='display' ot='abo' id=$item.id theme='Printer'}" title="{gt text='Open quick view window'}" style="display: none">
        {icon type='view' size='extrasmall' __alt='Quick view'}
    </a>
    <script type="text/javascript" charset="utf-8">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            muboardInitInlineWindow($('aboItem{{$item.id}}Display'), '{{$item.userid|replace:"'":""}}');
        });
    /* ]]> */
    </script>

    </li>
{/foreach}
</ul>
{/if}

