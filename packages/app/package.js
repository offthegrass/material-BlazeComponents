Package.describe({
    name: 'app',
    version: '0.0.1'
});

Package.onUse(function (api) {
    api.versionsFrom('1.1.0.2');

    // core packages
    api.use([

        'meteor-platform',
        'layout'

    ]);

    // third-party packages
    api.use([

        'fastclick'

    ], 'client');


    // blaze components
    api.use([

        'core-drawer-panel'

    ], 'client');

    // core files
    api.addFiles([

        'main.html',

    ], 'client');

});
