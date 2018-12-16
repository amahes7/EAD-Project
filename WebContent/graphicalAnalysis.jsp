<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ taglib prefix="t" uri="http://myfaces.apache.org/tomahawk"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Graphical Analysis</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body class="commonPages">
	<div class="commonPages-h1">
		<h1>Graphical Analysis</h1>
	</div>
	<f:view>
		<h:form>
			<div align="right">
				<h:commandButton value="Reset" action="#{graphics.resetButton}"
					styleClass="commonPages-commonbutton" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<h:commandButton value="Main Menu" action="mainMenu.jsp"
					actionListener="#{graphics.resetButton}"
					styleClass="commonPages-commonbutton" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<h:commandButton value="Logout" action="#{logout.processLogout}"
					styleClass="commonPages-commonbutton" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<hr>
			</div>
			<div class="commonPages-text" >
				<h3>Select Chart Type|Select Table Name</h3>
				<hr>
				<h:commandButton value="Generate Charts"
					action="#{graphics.generateChart}"
					rendered="#{graphics.renderGenerategraphButton}"
					styleClass="commonPages-largebutton" />
				<pre>
						<h:outputText value="#{graphics.message}"
						rendered="#{graphics.renderMessage}" />
					</pre>
				<h:panelGrid columns="5">
					<h:selectOneListbox id="displayCharts"
						value="#{graphics.chartType}" onchange="submit()"
						valueChangeListener="#{graphics.chartValueChanged}" size="6">
						<f:selectItem itemValue="0" itemLabel="Select Chart Type" />
						<f:selectItem itemValue="3" itemLabel="Scatterplot" />
						<f:selectItem itemValue="5" itemLabel="Histogram" />
					</h:selectOneListbox>
					<h:selectOneListbox id="selectOneCb"
						style="width:150px; height:100px"
						value="#{graphics.tableSelected}"
						rendered="#{graphics.renderTables}" size="5" onchange="submit()"
						valueChangeListener="#{graphics.tableValueChanged}">
						<f:selectItems value="#{statisticsBean.tableList}" />
					</h:selectOneListbox>
					<h:selectOneListbox id="Graphs"
						value="#{graphics.chartColumnSelected}"
						rendered="#{graphics.renderChartColumn}" size="5">
						<f:selectItems value="#{statisticsBean.numericData}" />
					</h:selectOneListbox>
					<h:selectOneListbox id="predictor1"
						value="#{graphics.predictorValue}" size="5"
						rendered="#{graphics.renderXYGraphColumns}">
						<f:selectItem itemValue="0" itemLabel="Select Predictor Value" />
						<f:selectItems value="#{statisticsBean.numericData}" />
					</h:selectOneListbox>
					<h:selectOneListbox id="response2"
						value="#{graphics.responseValue}" size="5"
						rendered="#{graphics.renderXYGraphColumns}">
						<f:selectItem itemValue="0" itemLabel="Select Response Value" />
						<f:selectItems value="#{statisticsBean.numericData}" />
					</h:selectOneListbox>
				</h:panelGrid>
				<hr />
				<div align="center">
				<h:graphicImage value="#{graphics.pieChartPath}" width="600"
					height="600" rendered="#{graphics.renderPieChart}" />
				<h:graphicImage value="#{graphics.barChartPath}" width="600"
					height="600" rendered="#{graphics.renderBarChart}" />
				<h:graphicImage value="#{graphics.xyChartPath}" width="600"
					height="600" rendered="#{graphics.xySeriesChart}" />
				<h:graphicImage value="#{graphics.xyTimeSeriesPath}" width="600"
					height="600" rendered="#{graphics.renderTimeSeriesChart}" />
				<h:graphicImage value="#{graphics.histPath}" width="600"
					height="600" rendered="#{graphics.renderHistChart}" />
				<br />
				</div>
			</div>
		</h:form>
	</f:view>
</body>
</html>