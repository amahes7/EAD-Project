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
<title>Import</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body class="commonPages">
	<div class="commonPages-h1">
		<h2>Import File</h2>
	</div>
	<f:view>
		<h:form enctype="multipart/form-data">
			<div align="right">
				<h:commandButton value="Main Menu" action="mainMenu.jsp"
					styleClass="commonPages-commonbutton" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<h:commandButton value="Logout" action="#{logout.processLogout}"
					styleClass="commonPages-commonbutton" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br />
				<hr>
			</div>
			<div align="center">
				<h:panelGrid columns="2">
					<h:outputLabel value="Select file to upload:" />
					<t:inputFileUpload id="fileUpload" label="File to upload"
						storage="default" value="#{dataImport.uploadedFile}" size="60" />
					<h:outputLabel value=" File Format:" />
					<h:selectOneListbox id="dataType" value="#{dataImport.format}"
						size="1" styleClass="forminput" required="true"
						requiredMessage="Required field">
						<f:selectItem itemValue="csv" itemLabel="CSV" />
					</h:selectOneListbox>
					<%-- <h:message for="dataType" style="color:red; font-size:90%" /> --%>
					<h:outputLabel value="Header Row" />
					<h:selectOneListbox id="headerR" value="#{dataImport.headerRow}"
						size="1" styleClass="forminput" required="true"
						requiredMessage="Required field">
						<f:selectItem itemValue="yes" itemLabel="Yes" />
						<f:selectItem itemValue="no" itemLabel="No" />
					</h:selectOneListbox>
					<h:message for="headerR" style="color:red; font-size:90%" />
					<h:outputText value="" />
					<h:commandButton id="upload" action="#{dataImport.uploadTypeFile}"
						value="Upload" styleClass="commonPages-button" />
					<h:commandButton id="reset" value="Reset"
						action="#{dataImport.reset}" styleClass="commonPages-button" />
				</h:panelGrid>
				<h:panelGrid columns="2" width="800"
					rendered="#{dataImport.fileImport }"
					style="  border-bottom-style: solid;
					border-top-style:solid; border-left-style: solid; border-right-style:solid">
					<h:outputLabel value="Number of records:" />
					<h:outputText value="#{dataImport.numberRows }" />
					<h:outputLabel value="File Name:" />
					<h:outputText value="#{dataImport.fileName }" />
				</h:panelGrid>
				<h:outputText value="#{dataImport.success}"
					rendered="#{dataImport.successRendered}" />
				<br></br>
				<h:outputText value="#{dataImport.message}"
					rendered="#{dataImport.renderMessage}" />
				<br /> <br />
				<h:outputText value="#{dataImport.errorMessage}"
					rendered="#{dataImport.renderMessage}" />
				<br></br>
				<h:outputText value="#{dataImport.errorRowMessage}"
					rendered="#{dataImport.renderRowMessage}"
					style="color:red; font-weight:bold" />
				<t:dataTable value="#{dataImport.errorRowList}" var="rowNumber"
					rendered="#{dataImport.renderTabledata}" border="1" cellspacing="0"
					cellpadding="1" headerClass="headerWidth">
					<t:columns var="col" value="#{dataImport.headr}">
						<f:facet name="header">
							<t:outputText styleClass="outputHeader" value="#{col}" />
						</f:facet>
						<t:outputText styleClass="outputText" value="#{rowNumber}" />
					</t:columns>
				</t:dataTable>
			</div>
		</h:form>
	</f:view>
</body>
</html>