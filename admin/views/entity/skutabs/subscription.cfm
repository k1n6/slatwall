<!---

    Slatwall - An Open Source eCommerce Platform
    Copyright (C) ten24, LLC

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

    Linking this program statically or dynamically with other modules is
    making a combined work based on this program.  Thus, the terms and
    conditions of the GNU General Public License cover the whole
    combination.

    As a special exception, the copyright holders of this program give you
    permission to combine this program with independent modules and your
    custom code, regardless of the license terms of these independent
    modules, and to copy and distribute the resulting program under terms
    of your choice, provided that you follow these specific guidelines:

	- You also meet the terms and conditions of the license of each
	  independent module
	- You must not alter the default display of the Slatwall name or logo from
	  any part of the application
	- Your custom code must not alter or create any files inside Slatwall,
	  except in the following directories:
		/integrationServices/

	You may copy and distribute the modified version of this program that meets
	the above guidelines as a combined work under the terms of GPL for this program,
	provided that you include the source code of that other code when and as the
	GNU GPL requires distribution of source code.

    If you modify this program, you may extend this exception to your version
    of the program, but you are not obligated to do so.

Notes:

--->
<cfimport prefix="swa" taglib="../../../../tags" />
<cfimport prefix="hb" taglib="../../../../org/Hibachi/HibachiTags" />

<cfparam name="rc.sku" type="any" />

<hb:HibachiPropertyRow>
	<hb:HibachiPropertyList>
		<hb:HibachiPropertyDisplay object="#rc.sku#" property="subscriptionTerm" edit="false">
		<hb:HibachiPropertyDisplay object="#rc.sku#" property="subscriptionBenefits" edit="#rc.edit#" displayType="plain">

		<cfif rc.edit>
			<cfif isNull(rc.sku.getRenewalSku())>
				<cfset renewalMethodDefault=rc.sku.getProduct().getRenewalMethodOptions()[2].value />
			<cfelse>
				<cfset renewalMethodDefault=rc.sku.getProduct().getRenewalMethodOptions()[1].value />
			</cfif>
			<hb:HibachiPropertyDisplay object="#rc.sku#" property="renewalMethod" valueDefault="#renewalMethodDefault#" valueOptions="#rc.sku.getProduct().getRenewalMethodOptions()#" edit=true>
		</cfif>

		<hb:HibachiDisplayToggle selector="select[name='renewalMethod']" showvalues="custom" loadVisable="#isNull(rc.sku.getRenewalSku())#">
            <hb:HibachiPropertyDisplay object="#rc.sku#" property="renewalPrice" edit="#rc.edit#">
            <hb:HibachiPropertyDisplay object="#rc.sku#" property="renewalSubscriptionBenefits" edit="#rc.edit#" displayType="plain">
		</hb:HibachiDisplayToggle>

		<hb:HibachiDisplayToggle selector="select[name='renewalMethod']" showvalues="renewalsku" loadVisable="#!isNull(rc.sku.getRenewalSku())#">
			<cfif !isNull(rc.sku.getRenewalSku()) && !rc.edit>
				<hb:HibachiPropertyDisplay object="#rc.sku#" property="renewalPrice" edit="#rc.edit#">
				<hb:HibachiPropertyDisplay object="#rc.sku.getRenewalSku()#" fieldname="renewalSku.skuCode" property="skuCode" edit="#rc.edit#" title="#$.slatwall.getRBKey('define.renewalSku')#" valuelink="#$.slatwall.buildURL(action='admin:entity.detailsku',querystring='skuID=#rc.sku.getRenewalSku().getSkuID()#')#"/>
			<cfelseif rc.edit>

				<cfif !isNull(rc.sku.getRenewalSku())>
					<cfset renewalSkuSelectValue=rc.sku.getRenewalSku().getSkuID() />
				<cfelse>
					<cfset renewalSkuSelectValue="" />
				</cfif>

				<swa:SlatwallErrorDisplay object="#rc.sku#" errorName="renewalSku" />
				<hb:HibachiListingDisplay smartList="#rc.sku.getProduct().getSubscriptionSkuSmartList()#"
										  selectValue="#renewalSkuSelectValue#"
										  selectFieldName="renewalSku.skuID"
										  title="#$.slatwall.rbKey('define.renewalSku')#"
										  edit="#rc.edit#">
					<hb:HibachiListingColumn propertyIdentifier="skuCode" />
					<hb:HibachiListingColumn propertyIdentifier="skuName" />
					<hb:HibachiListingColumn propertyIdentifier="skuDescription" />
					<hb:HibachiListingColumn propertyIdentifier="subscriptionTerm.subscriptionTermName" />
					<hb:HibachiListingColumn propertyIdentifier="price" />
				</hb:HibachiListingDisplay>
			</cfif>
		</hb:HibachiDisplayToggle>




	</hb:HibachiPropertyList>
</hb:HibachiPropertyRow>


