var muboardmodule = function(quill, options) {
    setTimeout(function() {
        var button;

        button = jQuery('button[value=muboardmodule]');

        button
            .css('background', 'url(' + Zikula.Config.baseURL + Zikula.Config.baseURI + '/web/modules/muboard/images/admin.png) no-repeat center center transparent')
            .css('background-size', '16px 16px')
            .attr('title', 'Board')
        ;

        button.click(function() {
            MUBoardModuleFinderOpenPopup(quill, 'quill');
        });
    }, 1000);
};
