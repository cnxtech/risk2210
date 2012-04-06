Ext.regModel('Player', {
    fields: [{name:'bio', type:'string', default:''},
    {name:'city', type:'string', default:''},
    {name:'email', type:'string', default:''},
    {name:'first_name', type:'string', default:''},
    {name:'gravatar_hash', type:'string', default:''},
    {name:'handle', type:'string', default:''},
    {name:'id', type:'int', default:'-1'},
    {name:'last_name', type:'string', default:''},
    {name:'slug', type:'string', default:''},
    {name:'website', type:'string', default:''},
    {name:'zip_code', type:'int', default:'00000'}]
});

ListDemo.ListStore = new Ext.data.Store({
    model: 'Player',
    proxy: {
        type: 'rest',
        url : '/players',
        appendId: true,
        buildUrl: function(request) {
        	var records = request.operation.records || [],
		        record  = records[0],
		        format  = this.format,
		        url     = request.url || this.url;
			if (request.action == "read"){
				url += '.json'
			}
		     
		    if (this.appendId && record) {
		        if (!url.match(/\/$/)) {
		            url += '/';
		        }
		
		        url += record.getId();
		    }
		
		    //finds ending slash and adds .{format}
		    if (format) {
		        if (!url.match(/\.$/)) {
		            url += '.';
		        }
		
		        url += format;
		    }
		
		    request.url = url;
		
		    return Ext.data.RestProxy.superclass.buildUrl.apply(this, arguments);
		},
        reader: {
            type: 'json',
            root: 'players'
        }
    },
    autoLoad: true
});

