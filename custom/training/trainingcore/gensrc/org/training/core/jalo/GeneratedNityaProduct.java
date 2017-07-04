/*
 * ----------------------------------------------------------------
 * --- WARNING: THIS FILE IS GENERATED AND WILL BE OVERWRITTEN! ---
 * --- Generated at 03-Jul-2017 00:28:18                        ---
 * ----------------------------------------------------------------
 */
package org.training.core.jalo;

import de.hybris.platform.jalo.Item.AttributeMode;
import de.hybris.platform.jalo.SessionContext;
import de.hybris.platform.jalo.product.Product;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import org.training.core.constants.TrainingCoreConstants;

/**
 * Generated class for type {@link org.training.core.jalo.NityaProduct nityaProduct}.
 */
@SuppressWarnings({"deprecation","unused","cast","PMD"})
public abstract class GeneratedNityaProduct extends Product
{
	/** Qualifier of the <code>nityaProduct.nityaPrId</code> attribute **/
	public static final String NITYAPRID = "nityaPrId";
	protected static final Map<String, AttributeMode> DEFAULT_INITIAL_ATTRIBUTES;
	static
	{
		final Map<String, AttributeMode> tmp = new HashMap<String, AttributeMode>(Product.DEFAULT_INITIAL_ATTRIBUTES);
		tmp.put(NITYAPRID, AttributeMode.INITIAL);
		DEFAULT_INITIAL_ATTRIBUTES = Collections.unmodifiableMap(tmp);
	}
	@Override
	protected Map<String, AttributeMode> getDefaultAttributeModes()
	{
		return DEFAULT_INITIAL_ATTRIBUTES;
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>nityaProduct.nityaPrId</code> attribute.
	 * @return the nityaPrId - Color of the product.
	 */
	public String getNityaPrId(final SessionContext ctx)
	{
		return (String)getProperty( ctx, NITYAPRID);
	}
	
	/**
	 * <i>Generated method</i> - Getter of the <code>nityaProduct.nityaPrId</code> attribute.
	 * @return the nityaPrId - Color of the product.
	 */
	public String getNityaPrId()
	{
		return getNityaPrId( getSession().getSessionContext() );
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>nityaProduct.nityaPrId</code> attribute. 
	 * @param value the nityaPrId - Color of the product.
	 */
	public void setNityaPrId(final SessionContext ctx, final String value)
	{
		setProperty(ctx, NITYAPRID,value);
	}
	
	/**
	 * <i>Generated method</i> - Setter of the <code>nityaProduct.nityaPrId</code> attribute. 
	 * @param value the nityaPrId - Color of the product.
	 */
	public void setNityaPrId(final String value)
	{
		setNityaPrId( getSession().getSessionContext(), value );
	}
	
}
