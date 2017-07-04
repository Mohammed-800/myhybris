/*
 * [y] hybris Platform
 *
 * Copyright (c) 2000-2016 hybris AG
 * All rights reserved.
 *
 * This software is the confidential and proprietary information of hybris
 * ("Confidential Information"). You shall not disclose such Confidential
 * Information and shall use it only in accordance with the terms of the
 * license agreement you entered into with hybris.
 *
 *
 */
ACC.liveEdit.baseSlotActionList = [
                                  {name: 'ADD', actionType: 'ADD', enabled: true, render: 'all'},
                                  {name: 'OVERRIDE', actionType: 'OVERRIDE', enabled: true, render: 'main'},
                                  {name: 'OVERRIDE_REVERSE', actionType: 'OVERRIDE_REVERSE', enabled: true, render: 'slot'},
                                  {name: 'EDIT_NAVIGATION', actionType: 'MENU', enabled: true, render: 'all'}
                                  ];

$(document).ready(function ()
{
	ACC.liveEdit.bindAll();
	$('.yCmsComponent').liveEditContextMenu();
	$('.yCmsContentSlot').liveEditSlotMenu({
		hidePseudo: 'BEFORE',
		baseActionList: ACC.liveEdit.baseSlotActionList
	});
    $('[data-cms-content-slot-position=NavigationBar]').liveEditPageSync();

});