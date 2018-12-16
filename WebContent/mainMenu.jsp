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
<title>MainMenu</title>
</head>
<body background="images/fourth.jpg">
	<f:view>
		<div class="main" align="center">
			<h1 class="mainmenu-h1">Main Menu</h1>
			<br> <br>
			<h:form>
				<div align="center">
					<h:commandButton value="Import Script" action="importScript.jsp"
						styleClass="mainmenu-button" />
					<br>
					<h:commandButton value="Data Import" action="import.jsp"
						styleClass="mainmenu-button" />
					<br>
					<h:commandButton value="Database Options"
						action="databaseOptions.jsp" styleClass="mainmenu-button" />
					<br>
					<h:commandButton value="Descriptive Statistics"
						action="descriptiveStats.jsp" styleClass="mainmenu-button" />
					<br>
					<h:commandButton value="Graphical Analysis"
						action="graphicalAnalysis.jsp" styleClass="mainmenu-button" />
					<br>
					<h:commandButton type="submit" value="Export Text File"
						action="#{dbAccess.writeToFile}" styleClass="mainmenu-button" />
					<br />
					<h:commandButton value="Logout" action="#{logout.processLogout}"
						styleClass="mainmenu-button" />
					<br>
				</div>
			</h:form>
		</div>
	</f:view>
</body>
</html>