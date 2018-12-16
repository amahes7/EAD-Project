<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ taglib prefix="t" uri="http://myfaces.apache.org/tomahawk"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<link rel="stylesheet" type="text/css" href="css/styles.css">
<title>Export</title>
</head>
<body class="commonPages">
	<div class="commonPages-h1">
		<h1>Export Files</h1>
	</div>
	<f:view>
		<h:form>
			<center>
				<div align="right">
					<h:commandButton value="Main Menu" action="mainMenu.jsp"
						styleClass="commonPages-commonbutton" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<h:commandButton value="Logout" action="#{logout.processLogout}"
						styleClass="commonPages-commonbutton" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
			</center>
			<hr>
			<h:panelGrid columns="2">
				<h:commandButton value="TableList" action="#{export.getTables}"
					styleClass="commonPages-commonbutton" />
				<h:commandButton value="Export CSV File "
					action="#{export.exportCSV}" styleClass="commonPages-largebutton" />
			</h:panelGrid>
			<h:panelGrid columns="1">
				<h:selectOneListbox id="selectOneCb" value="#{export.tableSelected}"
					rendered="#{export.renderTablename}" size="5">
					<f:selectItems value="#{export.tableList}" />
				</h:selectOneListbox>
			</h:panelGrid>
		</h:form>
	</f:view>
</body>
</html>