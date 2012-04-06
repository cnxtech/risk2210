
//todo: add leaf variable into list items, add multiple different classes to disclosure, update class after creation.
FactionList = Ext.extend(Ext.List, {
	 
	    initComponent: function(){
	    	var memberFnsCombo = {};
	    	
	        this.tpl = '<tpl for="."><div class="x-list-item ' + this.itemCls + '"><div class="x-list-item-body">' + this.itemTpl + '</div>';
	        if (this.onItemDisclosure) {
	        	this.tpl += '<tpl if="!leaf"><div class="x-list-disclosure"></div></tpl>';
	        }
	        this.tpl += '</div></tpl>';
	        this.tpl = new Ext.XTemplate(this.tpl, memberFnsCombo);
        
	        FactionList.superclass.initComponent.call(this);
	 
	     }
	});

NewGame = new Ext.Application({
    name: "NewGame",

    launch: function() {
    	
    	NewGame.buildFactionCar();
    	
    	NewGame.FactionCar = new Ext.Carousel({
    		id:'factioncar',
            defaults: {
                cls: 'card',
                align:'center'
            },
            items: [
            	//{html: '<h1>Faction Name</h1><p>image here</p> <p>description text here</p> <p>starting dracna</p> <p>staring cards </p>'}
            ],
			dockedItems: [
                {
                    xtype: 'toolbar',
                    dock:'bottom',
                    items: [
                    	{
                    		xtype:'spacer'
 	                   	},
                    	{
                        text: 'select',
                        ui: 'confirm',
                        handler: function() {
                        	var curFaction = NewGame.FactionCar.getActiveItem();
                        	NewGame.curPlayer.faction_id = curFaction.id;
                        	NewGame.curPlayer.faction_name = curFaction.name;
                        	NewGame.curPlayer.faction_index = NewGame.FactionCar.getActiveIndex();
                        	
                        	NewGame.PlayersList.refresh();
                        	NewGame.PlayersPanel.setActiveItem('playerslist');
                        	}
                        },                    
                    	{
                    		xtype:'spacer'
 	                   	}]
                }
            ]            
        });
        
    	//list of user
        NewGame.PlayersList = new FactionList({
            id: 'playerslist',
            type: 'light',
            multiSelect: true,
            store: NewGame.PlayerStore,
            singleSelect: false,
            itemTpl: '<div class="gamePlayer" id="playerselect_{#}"><input type="checkbox" id="selected_{#}" disabled="true"/> <span class="handle">{handle}</span> -- <span class="email">{email}</span> <span class="faction">{faction_name}</span></div>',
			listeners:{
				itemtap: function(list, index){
					//template autonumber starts at 1, list index is 0 based
					index = index+1;
					var player = Ext.getDom('selected_'+index);
						NewGame.checkPlayer(player);
                }   
			},
            onItemDisclosure: function(record, btn, index) {
                //ListDemo.detailPanel.update(record.data);
            	NewGame.curPlayer = record.data;
                NewGame.PlayersPanel.setActiveItem('factioncar');
                if(record.data.faction_index != null){
                	NewGame.FactionCar.setActiveItem(record.data.faction_index);
                }
                
            }
        });
        
        //Can't add a list directly to a tabbed panel, so wrap it
        NewGame.PlayersPanel = new Ext.Panel({
        	id: 'playerspanel',
        	layout:'card',
        	title:'Select Players',
        	items:[NewGame.PlayersList, NewGame.FactionCar]
    	});
    	
    	//config panel
    	NewGame.ConfigPanel = new Ext.form.FormPanel({
    		id:'configpanel',
    		title: 'Config Options',
            scroll: 'vertical',
            url   : '/games/new',
            standardSubmit : false,
            submit:{
            	method:'post',
                url: '/games/create',
            	params:{
					//location:NewGame.ConfigPanel.items[0].value,
					//players: NewGame.getSelectedPlayers()
            	}
            	
            },
            listeners : {
                submit : function(form, result){
                    console.log('success', Ext.toArray(arguments));
                },
                exception : function(form, result){
                    console.log('failure', Ext.toArray(arguments));
                }                
            },
			items: [
				 {
                    xtype: 'fieldset',
                    items: [{
	                        xtype: 'textfield',
	                        id:'location',
	                        label: 'Location'
                    	},{
                    		xtype:'numberfield',
                    		id:'numyears',
                    		label:'# Years',
                    		value:'5'
                    	},
                    	{
                    		xtype:'textareafield',
                    		id:'rulemods',
                    		label:'Rule changes',
                    		value:''
                    	}]
                }]            
    	});
    	
    	//tabbed panel to hold all our panels
        NewGame.Viewport = new Ext.TabPanel({
            fullscreen: true,
            type: 'light',
            sortable: true,
			dockedItems: [
                {
                    xtype: 'toolbar',
                    id: 'setuptoolbar',
                    items: [
                    	{
                        text: 'Home',
                        ui: 'back',
                        handler: function() {
                            window.location = '/';
                        }
                        },                    
                    	{
                    		xtype:'spacer'
 	                   	},
                    	{
                        text: 'Start Game',
                        ui: 'confirm',
                        handler: NewGame.StartGame
                    }]
                }
            ],            
            items: [NewGame.PlayersPanel, NewGame.ConfigPanel]
        });

    }
});
//accept checkbox html input, flips checkbox checked value
NewGame.checkPlayer = function(cBox){
	if(cBox != null){
		cBox.checked = !cBox.checked; 
	}
}

//gets all factions cards, builds the cards carousel, loads created pages in carousel
NewGame.buildFactionCar = function(){
	NewGame.factionPages = new Array();
	
	Ext.Ajax.request({
	url: '/factions.json',
	method: 'GET',
		callback: function(options, success, response) {
			var decoded = Ext.util.JSON.decode(response.responseText);
			var factions = decoded.factions;
			var image ='';

			for (f = 0; f < factions.length; f++)
			{
				//resources = '';
				//for (r = 0; r <factions[f].starting_resources.length; r++){
					//resources += '<p>' + factions[f].starting_resources[r] + '</p>';
				//}
				//NewGame.factionPages.push({html: '<image src="/assets/faction_cards/havoc.jpg"/> <h1>'+ factions[f].name +'</h1><p><img src="/assets/faction_cards/'+ factions[f].name.replace(' ', '_') +'.jpg"/></p> <p>'+ factions[f].abilities +'</p>' + resources})
				image = '<img src="/assets/faction_cards/'+ factions[f].name.toLowerCase().replace(/ /g, '_') +'.jpg"/>';
				NewGame.factionPages.push({id: factions[f].id, name: factions[f].name, html: '<title>'+ factions[f].name +'</title><p>'+ image +'</p>'});
			}
			
			NewGame.FactionCar.add(NewGame.factionPages);
		}
	});
}

NewGame.StartGame = function(){
	//run validation
	//NewGame.ConfigPanel.Submit();
	NewGame.curPlayer = {};
}

Ext.regModel('Player', {
    fields: [
        'email',
        'handle',
        'id',
        {name:'faction_id',		type: 'int'},
        {name:'faction_index',	type: 'int'},
    	{name:'faction_name',	type: 'string'}]
});

Ext.regModel('GamePlayer', {
    fields: [
    {name:'player_id',		type: 'int'},
    {name:'game_id',		type: 'int'},
    {name:'faction_id',		type: 'int'},
    {name:'faction_name',	type: 'string'}]
});

Ext.regModel('Game', {
    fields: [
        'location',
        'players']
});

NewGame.PlayerStore = new Ext.data.Store({
    model: 'Player',
    sorters: 'handle',
    getGroupString : function(record) {
        return record.get('handle')[0];
    },
  	proxy: {
        type: 'ajax',
        url : '/players.json',
        reader: {
            type: 'json',
            root: 'players'
        }
    },
    autoLoad: true
});

Ext.regModel('Map', {
    fields: ['id','label',
        'checked']
});

NewGame.ContactStore = new Ext.data.Store({
    model: 'map',
  	proxy: {
        type: 'ajax',
        url : '/players.json',
        reader: {
            type: 'json',
            root: 'players'
        }
    }
});