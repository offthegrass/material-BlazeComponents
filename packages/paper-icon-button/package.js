Package.describe({
    name: 'paper-icon-button',
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

    api.use([

        'meteor-platform',
        'coffeescript',
        'fastclick',
        'peerlibrary:blaze-components@0.7.0'

    ], 'client');


    api.use([
        'paper-ripple',
        'core-icon'
    ]);

    api.addFiles([

        'paper-icon-button.html',
        'paper-icon-button.css',
        'paper-icon-button.coffee'

    ], 'client');
});

Package.onTest(function (api) {
    api.use('tinytest');
    api.use('paper-icon-button');
    api.addFiles('paper-icon-button-tests.js');
});
