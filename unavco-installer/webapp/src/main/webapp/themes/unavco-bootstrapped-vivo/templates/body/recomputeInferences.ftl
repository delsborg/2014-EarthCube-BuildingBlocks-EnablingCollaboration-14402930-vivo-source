<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#if formAction?has_content>
    <form method="post" action="${formAction}">
        <input class="btn btn-success submit" type="submit" value="${i18n().recompute_inferences}" name="submit" role="input" />
    </form>
</#if>

<#if message?has_content>
    <p>${message}</p>
</#if>
