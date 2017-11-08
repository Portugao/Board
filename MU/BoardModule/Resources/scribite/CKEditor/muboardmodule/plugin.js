CKEDITOR.plugins.add('muboardmodule', {
    requires: 'popup',
    init: function (editor) {
        editor.addCommand('insertMUBoardModule', {
            exec: function (editor) {
                MUBoardModuleFinderOpenPopup(editor, 'ckeditor');
            }
        });
        editor.ui.addButton('muboardmodule', {
            label: 'Board',
            command: 'insertMUBoardModule',
            icon: this.path.replace('scribite/CKEditor/muboardmodule', 'images') + 'admin.png'
        });
    }
});
