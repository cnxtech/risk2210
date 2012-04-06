ListDemo = new Ext.Application({
	name : "ListDemo",

	launch : function() {

		ListDemo.detailPanel = new Ext.form.FormPanel({
					id : 'detailpanel',
					scroll : 'vertical',
					xtype : 'fieldset',
					title : 'Player Details',
					url : '/mobile/player',
					instructions : 'Please enter the information above.',
					defaults : {
						required : false,
						labelAlign : 'left',
						labelWidth : '40%'
					},
					items : [{
								xtype : 'textfield',
								name : 'handle',
								label : 'Handle',
								required : true
							}, {
								xtype : 'emailfield',
								name : 'email',
								label : 'Email',
								required : true
							}, {
								xtype : 'textfield',
								name : 'first_name',
								label : 'First name'
							}, {
								xtype : 'textfield',
								name : 'last_name',
								label : 'Last name'
							}, {
								xtype : 'urlfield',
								name : 'website',
								label : 'Website'
							}, {
								xtype : 'textfield',
								name : 'slug',
								label : 'Profile header'
							}, {
								xtype : 'textfield',
								name : 'last_login_at',
								label : 'last_login_at'
							}, {
								xtype : 'textfield',
								name : 'city',
								label : 'City'
							}, {
								xtype : 'textfield',
								name : 'zip_code',
								label : 'Zip Code'
							}, {
								xtype : 'textareafield',
								name : 'bio',
								label : 'Bio',
								maxLength : 60,
								maxRows : 10
							}],
					dockedItems : [{
						xtype : 'toolbar',
						items : [{
									text : 'Back',
									ui : 'back',
									handler : fn_SlideBack
								}, {
									text : 'Save',
									ui : 'confirm',
									handler : function() {
										ListDemo.detailPanel.updateRecord(ListDemo.detailPanel.getRecord());
										ListDemo.ListStore.sync(); //-- used when autosave is setup on store
										fn_SlideBack();
										//ListDemo.detailPanel.submit();
										// update notes
										// console.log(';still not saving...
										// might have to use sencha view with
										// the model for autosave' +
										// ListDemo.detailPanel.getValues());

										// ListDemo.Contact.sync();
										// if(ListDemo.Contact){
										// ListDemo.detailPanel.updateRecord(ListDemo.Contact,
										// true);
										// }
										// ListDemo.detailPanel.submit({
										// waitMsg : {message:'Submitting', cls
										// :
										// 'demos-loading'}
										// });
									}
								}]
					}]
				});

		ListDemo.listPanel = new Ext.List({
					id : 'disclosurelist',
					store : ListDemo.ListStore,
					itemTpl : '<div class="contact">{handle} -- {email}</div>',
					onItemDisclosure : function(record, btn, index) {

						ListDemo.detailPanel.loadModel(record);
						// ListDemo.detailPanel.load(Ext.ModleMgr.get(record.id));
						// debugger;
						ListDemo.Viewport.setActiveItem('detailpanel');

					}
				});

		ListDemo.wrapperPanel = new Ext.Panel({
					id : 'wrapperpanel',
					items : [ListDemo.listPanel],
					dockedItems : [{
								xtype : 'toolbar',
								title : 'Players',
								items : []
							}]
				});

		ListDemo.Viewport = new Ext.Panel({
					fullscreen : true,
					layout : 'card',
					cardSwitchAnimation : 'slide',
					items : [ListDemo.wrapperPanel, ListDemo.detailPanel],
					tabBar : {
						dock : 'bottom',
						layout : {
							pack : 'center'
						}
					}
				});

	}
});

function fn_SlideBack() {
	ListDemo.Viewport.setActiveItem('wrapperpanel', {
				type : 'slide',
				direction : 'right'
			});
}
