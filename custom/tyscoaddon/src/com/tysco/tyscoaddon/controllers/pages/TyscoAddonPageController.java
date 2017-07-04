/**
 *
 */
package com.tysco.tyscoaddon.controllers.pages;

import de.hybris.platform.addonsupport.controllers.page.AbstractAddOnPageController;
import de.hybris.platform.cms2.exceptions.CMSItemNotFoundException;
import de.hybris.platform.cms2.model.pages.ContentPageModel;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


/**
 * @author guvvaa
 *
 */

@Controller
@RequestMapping(value = "/tysco")
public class TyscoAddonPageController extends AbstractAddOnPageController
{

	@RequestMapping(method = RequestMethod.GET)

	public String tysco(final Model model) throws CMSItemNotFoundException
	{
		final ContentPageModel page = getContentPageForLabelOrId(null);
		storeCmsPageInModel(model, page);
		setUpMetaDataForContentPage(model, page);
		return "addon:/tyscoaddon/pages/tyscoAddonPage";
	}
}
