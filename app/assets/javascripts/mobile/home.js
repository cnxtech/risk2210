Ext.setup({
    icon: 'icon.png',
    glossOnIcon: false,
    tabletStartupScreen: 'tablet_startup.png',
    phoneStartupScreen: 'phone_startup.png',
    onReady: function() {
        new Ext.Panel({
            fullscreen: true,
            type: 'dark',
            sortable: true,
            items: [{
                xtype:'button',
                text: 'Create game',
                handler: function(){window.location = '/mobile/game';}
            }, {
                xtype:'button',
                text: 'Update player details',
                handler: function(){window.location = '/mobile/player';}
            }]
        });
    }
 });