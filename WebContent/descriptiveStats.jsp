<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ taglib prefix="t" uri="http://myfaces.apache.org/tomahawk"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Descriptive Statistics</title>
<link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body class="commonPages">
	<div class="commonPages-h1">
		<h1>Descriptive Statistics</h1>
	</div>
	<f:view>
		<h:form>
			<div align="right">
				<h:commandButton value="Reset"
					action="#{statisticsBean.resetButton}"
					styleClass="commonPages-button" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<h:commandButton value="Main Menu" action="mainMenu.jsp"
					styleClass="commonPages-commonbutton" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<h:commandButton value="Logout" action="#{logout.processLogout}"
					styleClass="commonPages-commonbutton" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br />
				<hr>
			</div>
			<div align="center">
				<h:panelGrid columns="8">
					<h:commandButton value="TableList"
						action="#{statisticsBean.getTables}"
						styleClass="commonPages-button" />
					<h:commandButton value="ColumnList"
						action="#{statisticsBean.getColumnNames}"
						styleClass="commonPages-button"
						disabled="#{statisticsBean.renderColumnListbutton}" />
					<h:commandButton value="TableMetaData"
						action="#{statisticsBean.getTableMetaData}"
						styleClass="commonPages-button" />
					<h:commandButton value="GetStatistics"
						action="#{statisticsBean.generateReport}"
						styleClass="commonPages-button"
						disabled="#{statisticsBean.renderReport}" />
					<h:commandButton value="SelectVariables"
						action="#{statisticsBean.displayColumnsforRegression}"
						styleClass="commonPages-button" />
					<h:commandButton value="RegressionAnalysis"
						action="#{statisticsBean.generateRegressionReport}"
						styleClass="commonPages-largebutton"
						disabled="#{statisticsBean.renderRegressionButton}" />
					<h:commandButton value="Correlation"
						action="#{statisticsBean.correlateVariables}"
						styleClass="commonPages-button" />
				</h:panelGrid>
			</div>
			<pre>
						<h:outputText value="#{statisticsBean.message}"
					rendered="#{statisticsBean.renderMessage}" style="color:red" />
					</pre>
			<h:panelGrid columns="4">
				<h:selectOneListbox id="selectOneCb"
					style="width:150px; height:100px"
					value="#{statisticsBean.tableSelected}"
					rendered="#{statisticsBean.renderTablename}" size="5">
					<f:selectItems value="#{statisticsBean.tableList}" />
				</h:selectOneListbox>
				<h:selectManyListbox id="selectcolumns"
					style="width:150px; height:100px"
					value="#{statisticsBean.columnSelected}"
					rendered="#{statisticsBean.columnRender}" size="5">
					<f:selectItems value="#{statisticsBean.columnsList}" />
				</h:selectManyListbox>
				<h:selectOneListbox id="predictor"
					value="#{statisticsBean.predictorValue}"
					rendered="#{statisticsBean.renderRegressionColumn}" size="5">
					<f:selectItem itemValue="0" itemLabel="Select Independent Variable" />
					<f:selectItems value="#{statisticsBean.numericData}" />
				</h:selectOneListbox>
				<h:selectOneListbox id="response"
					value="#{statisticsBean.responseValue}"
					rendered="#{statisticsBean.renderRegressionColumn}" size="5">
					<f:selectItem itemValue="0" itemLabel="Select Dependent Variable" />
					<f:selectItems value="#{statisticsBean.numericData}" />
				</h:selectOneListbox>

			</h:panelGrid>
			<div class="commonPages-text">
				<h:outputText value="No. of Rows: "
					rendered="#{statisticsBean.renderTableMetaData}" />
				<h:outputText value="#{statisticsBean.rowcount}"
					rendered="#{statisticsBean.renderTableMetaData}" />
				<br />
				<h:outputText value="No. of Columns: "
					rendered="#{statisticsBean.renderTableMetaData}" />
				<h:outputText value="#{statisticsBean.colcount} "
					rendered="#{statisticsBean.renderTableMetaData}" />
				<hr />
				<div align=center>
					<h:panelGrid columns="4"
						rendered="#{statisticsBean.renderCorrelationResult}" border="2">
						<h:outputText value="Predictor Variable" />
						<h:outputText value="Response Variable" />
						<h:outputText value="Correlation" />
						<h:outputText value="P-Value" />
						<h:outputText value="#{statisticsBean.predictorValue}" />
						<h:outputText value="#{statisticsBean.responseValue}" />
						<h:outputText value="#{statisticsBean.corr}" />
						<h:outputText value="#{regression.pValue}" />
					</h:panelGrid>
					<h:panelGrid columns="1"
						rendered="#{statisticsBean.renderCorrelationResult}" border="2">
						<h:outputText
							value="Cell Contents : Pearson Correlation (P-Value)" />
					</h:panelGrid>
				</div>
				<div
					style="background-attachment: scroll; overflow: auto; background-repeat: repeat"
					align="center">
					<t:dataTable value="#{statisticsBean.statisticList}"
						var="rowNumber" rendered="#{statisticsBean.renderTabledata}"
						border="1" cellspacing="0" cellpadding="1"
						headerClass="headerWidth">
						<h:column>
							<f:facet name="header">
								<h:outputText value="Column Selected" />
							</f:facet>
							<h:outputText value="#{rowNumber.columnSelected}" />
						</h:column>
						<h:column>
							<f:facet name="header">
								<h:outputText value="Minimum Value" />
							</f:facet>
							<h:outputText value="#{rowNumber.minValue}" />
						</h:column>
						<h:column>
							<f:facet name="header">
								<h:outputText value="Maximum Value" />
							</f:facet>
							<h:outputText value="#{rowNumber.maxValue}" />
						</h:column>
						<h:column>
							<f:facet name="header">
								<h:outputText value="Mean" />
							</f:facet>
							<h:outputText value="#{rowNumber.mean}" />
						</h:column>
						<h:column>
							<f:facet name="header">
								<h:outputText value="Variance" />
							</f:facet>
							<h:outputText value="#{rowNumber.variance}" />
						</h:column>
						<h:column>
							<f:facet name="header">
								<h:outputText value="Standard Deviation" />
							</f:facet>
							<h:outputText value="#{rowNumber.std}" />
						</h:column>
						<h:column>
							<f:facet name="header">
								<h:outputText value="Q1" />
							</f:facet>
							<h:outputText value="#{rowNumber.q1}" />
						</h:column>
						<h:column>
							<f:facet name="header">
								<h:outputText value="Q3" />
							</f:facet>
							<h:outputText value="#{rowNumber.q3}" />
						</h:column>
						<h:column>
							<f:facet name="header">
								<h:outputText value="Range" />
							</f:facet>
							<h:outputText value="#{rowNumber.range}" />
						</h:column>
						<h:column>
							<f:facet name="header">
								<h:outputText value="IQR" />
							</f:facet>
							<h:outputText value="#{rowNumber.iqr}" />
						</h:column>
					</t:dataTable>
				</div>
				<br />
				<h:outputText value="Regression Equation: "
					rendered="#{statisticsBean.renderRegressionResult}">
				</h:outputText>
				<h:outputText value="#{regression.regressionEquation}"
					rendered="#{statisticsBean.renderRegressionResult}">
				</h:outputText>
				<br /> <br />
				<h:outputText value="Regression Model"
					rendered="#{statisticsBean.renderRegressionResult}"></h:outputText>
				<h:panelGrid columns="5"
					style="background-color: Beige;
border-bottom-style: solid;
border-top-style: solid;
border-left-style: solid;
border-right-style: solid"
					rendered="#{statisticsBean.renderRegressionResult}" border="1">
					<h:outputText value="Predictor" />
					<h:outputText value="Co-efficient" />
					<h:outputText value="Standard Error Co-efficient" />
					<h:outputText value="T-Statistic" />
					<h:outputText value="P-Value" />
					<h:outputText value="Constant" />
					<h:outputText value="#{regression.intercept}" />
					<h:outputText value="#{regression.interceptStandardError}" />
					<h:outputText value="#{regression.tStatistic }" />
					<h:outputText value="#{regression.interceptPValue }" />
					<h:outputText value="#{statisticsBean.predictorValue}" />
					<h:outputText value="#{regression.slope}" />
					<h:outputText value="#{regression.slopeStandardError}" />
					<h:outputText value="#{regression.tStatisticPredictor }" />
					<h:outputText value="#{regression.pValuePredictor }" />
				</h:panelGrid>
				<br /> <br />
				<h:panelGrid columns="2"
					rendered="#{statisticsBean.renderRegressionResult}" border="1">
					<h:outputText value="Model Standard Error:" />
					<h:outputText value="#{regression.standardErrorModel}" />
					<h:outputText value="R Square(Co-efficient of Determination)" />
					<h:outputText value="#{regression.rSquare}" />
					<h:outputText
						value="R Square Adjusted(Co-efficient of Determination)" />
					<h:outputText value="#{regression.rSquareAdjusted}" />
				</h:panelGrid>
				<br /> <br />
				<h:outputText value="ANOVA"
					rendered="#{statisticsBean.renderRegressionResult}" />
				<br />
				<h:panelGrid columns="6"
					rendered="#{statisticsBean.renderRegressionResult}" border="1">
					<h:outputText value="Source" />
					<h:outputText value="Degrees of Freedom(DF)" />
					<h:outputText value="Sum of Squares" />
					<h:outputText value="Mean of Squares" />
					<h:outputText value="F-Statistic" />
					<h:outputText value="P-Value" />
					<h:outputText value="Regression" />
					<h:outputText value="#{regression.predictorDF}" />
					<h:outputText value="#{regression.regressionSumSquares}" />
					<h:outputText value="#{regression.meanSquare }" />
					<h:outputText value="#{regression.fValue }" />
					<h:outputText value="#{regression.pValue}" />
					<h:outputText value="Residual Error" />
					<h:outputText value="#{regression.residualErrorDF}" />
					<h:outputText value="#{regression.sumSquaredErrors }" />
					<h:outputText value="#{regression.meanSquareError }" />
					<h:outputText value="" />
					<h:outputText value="" />
					<h:outputText value="Total" />
					<h:outputText value="#{regression.totalDF}" />
				</h:panelGrid>
		</h:form>
	</f:view>
</body>
</html>