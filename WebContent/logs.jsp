<?xml version='1.0' encoding='UTF-8' ?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ taglib prefix="t" uri="http://myfaces.apache.org/tomahawk"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>S18T22</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
	<f:view>
		<div class="commonPages-text">
			<h2>Access logs</h2>
			<h:form>
				<div align="right">
				<h:commandButton value="Main Menu" action="mainMenu.jsp"
					styleClass="commonPages-commonbutton" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<h:commandButton value="Logout" action="#{logout.processLogout}"
					styleClass="commonPages-commonbutton" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<hr />
			</div>
				<h:commandButton value="GenerateLogs"
					action="#{dbOperations.getIpTableData}" styleClass="commonPages-button" />
				<br />
				<pre>
						<h:outputText value="#{log.message}"
						rendered="#{log.renderMessage}" style="color:red" />
						<h:outputText value="#{dbOperations.message}"
						rendered="#{dbOperations.renderMessage}" />
					</pre>
				<br />
					<div style="background-attachment: scroll; overflow:auto;
                    		height:300px; background-repeat: repeat" align="center">
                        <t:dataTable value="#{dbOperations.resultIpTableData}" var="row"
				            rendered="#{dbOperations.renderLogTable}"
				            border="1" cellspacing="0" cellpadding="1"
                            columnClasses="columnClass border"
				            headerClass="headerClass" footerClass="footerClass"
                            rowClasses="rowClass2" 
				            width="900px">
                            <t:columns var="col" value="#{dbOperations.logColumns}">
                                <f:facet name="header">
                                    <t:outputText  value="#{col}" />
                                </f:facet>
                                <t:outputText value="#{row[col]}" />
                            </t:columns>
                        </t:dataTable>	
				    </div> 
			</h:form>
		</div>
	</f:view>
</body>
</html>