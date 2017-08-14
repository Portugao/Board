CKEDITOR.plugins.add('muboardmodule', {
    requires: 'popup',
    lang: 'en,nl,de',
    init: function (editor) {
        editor.addCommand('insertMUBoardModule', {
            exec: function (editor) {
                var url = Routing.generate('muboardmodule_external_finder', { objectType: 'category', editor: 'ckeditor' });
                // call method in MUBoardModule.Finder.js and provide current editor
                MUBoardModuleFinderCKEditor(editor, url);
            }
        });
        editor.ui.addButton('muboardmodule', {
            label: editor.lang.muboardmodule.title,
            command: 'insertMUBoardModule',
            icon: this.path.replace('scribite/CKEditor/muboardmodule', 'public/images') + 'admin.png'
        });
    }
});
