<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ taglib prefix="t" uri="http://myfaces.apache.org/tomahawk"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>DataBase Operations</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body class="commonPages">
	<f:view>
		<h:form>
			<div class="commonPages-h1">
				<h1>DataBase Operations</h1>
				<hr>
			</div>
			<div class="commonPages-h2">
				<h2>Schema : World</h2>
			</div>
			<div align="right">
				<h:commandButton value="Reset" action="#{dbOperations.resetButton}"
					styleClass="commonPages-commonbutton" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<h:commandButton value="Main Menu" action="mainMenu.jsp"
					styleClass="commonPages-commonbutton" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<h:commandButton value="Logout" action="#{logout.processLogout}"
					styleClass="commonPages-commonbutton" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			</div>
			<hr>
			<div align="center">
				<h:panelGrid columns="5">
					<h:commandButton value="TableList"
						action="#{dbOperations.getTables}" styleClass="commonPages-button" />
					<h:commandButton value="ColumnList"
						action="#{dbOperations.getColumnNames}"
						styleClass="commonPages-button" />
					<h:commandButton value="DisplayTable"
						action="#{dbOperations.getTableData}"
						styleClass="commonPages-button" />
					<h:commandButton value="DisplaySelectedColumns"
						action="#{dbOperations.getColumnData}"
						styleClass="commonPages-largebutton" />
					<h:commandButton value="ProcessSQLQuery"
						action="#{dbOperations.processQuery}"
						styleClass="commonPages-largebutton" />
				</h:panelGrid>
				<h:panelGrid columns="3">
					<h:commandButton value="See Descriptive Stats"
						action="descriptiveStats.jsp"
						actionListener="#{statisticsBean.setSelectedTable}"
						styleClass="commonPages-largebutton" />
					<h:commandButton value="See Graphical Analysis"
						action="graphicalAnalysis.jsp"
						actionListener="#{graphics.setSelectedTable}"
						styleClass="commonPages-largebutton" />
					<h:commandButton value="Export Columns"
						action="#{dbOperations.exportColumns}"
						styleClass="commonPages-largebutton" />
				</h:panelGrid>
			</div>
			<pre>
						<h:outputText value="#{dbOperations.message}"
					rendered="#{dbOperations.renderMessage}" style="color:red" />
					</pre>
			<hr>
			<div class="commonPages-text">
				<div align="center">
					<h:panelGrid columns="4">
						<h:outputText value="Select Table"
							rendered="#{dbOperations.renderTablename}" />
						<h:outputText value="Select Column"
							rendered="#{dbOperations.columnRender}" />
						<h:outputText value="Write Query"
							rendered="#{dbOperations.columnRender}" />
						<h:outputText value="" />
						<h:selectOneListbox id="selectOneCb"
							value="#{dbOperations.tableSelected}"
							rendered="#{dbOperations.renderTablename}" size="5">
							<f:selectItems value="#{dbOperations.tableList}" />
						</h:selectOneListbox>
						<h:selectManyListbox id="selectcolumns"
							value="#{dbOperations.columnSelected}"
							rendered="#{dbOperations.columnRender}" size="10">
							<f:selectItems value="#{dbOperations.columnsList}" />
						</h:selectManyListbox>
						<h:inputTextarea rows="6" cols="40" style="height:100px"
							value="#{dbOperations.userQuery}"
							rendered="#{dbOperations.columnRender}" />
					</h:panelGrid>
				</div>
				<hr>
				<h:outputText value="Query : "
					rendered="#{dbOperations.renderTabledata}" />
				<h:outputText value="#{dbOperations.userQuery}"
					rendered="#{dbOperations.renderTabledata}" />
				<br />
				<h:outputText value="Rows : "
					rendered="#{dbOperations.renderTabledata}" />
				<h:outputText value="#{dbOperations.rowsAffected}"
					rendered="#{dbOperations.renderTabledata}" />
				<br />
				<h:outputText value="Columns : "
					rendered="#{dbOperations.renderTabledata}" />
				<h:outputText value="#{dbOperations.columnCount}"
					rendered="#{dbOperations.renderTabledata}" />
				<hr />
				<div align="center">
					<h:panelGrid columns="2" style="background-color: Beige;">
						<h:outputText value="Select Source"
							rendered="#{dbOperations.renderCompute}" />
						<h:outputText value="Select Destination"
							rendered="#{dbOperations.renderCompute}" />
						<h:selectOneListbox id="selectSource"
							value="#{dbOperations.source}"
							rendered="#{dbOperations.renderCompute}" size="5">
							<f:selectItems value="#{dbOperations.sourcecolList}" />
						</h:selectOneListbox>
						<h:selectOneListbox id="selectDestination"
							value="#{dbOperations.destination}"
							rendered="#{dbOperations.renderCompute}" size="5">
							<f:selectItems value="#{dbOperations.sourcecolList}" />
						</h:selectOneListbox>
					</h:panelGrid>
				</div>
				<div
					style="background-attachment: scroll; overflow: auto; height: 300px; background-repeat: repeat"; align:left ">
					<t:dataTable value="#{dbOperations.result}" var="row"
						rendered="#{dbOperations.renderTabledata}" border="1">
						<t:columns var="col" value="#{dbOperations.columnSelected}">
							<f:facet name="header">
								<t:outputText styleClass="outputHeader" value="#{col}" />
							</f:facet>
							<t:outputText styleClass="outputText" value="#{row[col]}" />
						</t:columns>
					</t:dataTable>
				</div>
			</div>
			<hr />
		</h:form>
	</f:view>
</body>
</html>