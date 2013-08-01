{* purpose of this template: inclusion template for display of related Users in user area *}

<h4>
    <a href="{modurl modname='MUBoard' type='user' func='display' ot='user' id=$item.id}">
        {$item.userid}
    </a>
    <a id="userItem{$item.id}Display" href="{modurl modname='MUBoard' type='user' func='display' ot='user' id=$item.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" style="display: none">
        {icon type='view' size='extrasmall' __alt='Quick view'}
    </a>
</h4>
    <script type="text/javascript" charset="utf-8">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            muboardInitInlineWindow($('userItem{{$item.id}}Display'), '{{$item.userid|replace:"'":""}}');
        });
    /* ]]> */
    </script>

