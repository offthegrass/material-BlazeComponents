Package.describe({
    name: 'core-toolbar',
    version: '0.0.1',
    // Brief, one-line summary of the package.
    summary: '',
    // URL to the Git repository containing the source code for this package.
    git: '',
    // By default, Meteor will default to using README.md for documentation.
    // To avoid submitting documentation, set this field to null.
    documentation: 'README.md'
});

Package.onUse(function (api) {
    api.versionsFrom('1.1.0.2');

    // core
    api.use([

        'meteor-platform',
        'coffeescript',
        'fastclick',
        'peerlibrary:blaze-components@0.7.0'

    ], 'client');


    // BlazeComponents
    api.use([

    ], 'client');


    api.addFiles([

        'core-toolbar.html',
        'core-toolbar.css',
        'core-toolbar.coffee'

    ], 'client');

});

Package.onTest(function (api) {
    api.use('tinytest');
    api.use('core-toolbar');
    api.addFiles('core-toolbar-tests.js');
});
