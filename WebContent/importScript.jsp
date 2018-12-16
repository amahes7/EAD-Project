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
<title>Import Script</title>
</head>
<body class="commonPages">
	<div class="commonPages-h1">
		<h1>
			<u>Import Script</u>
		</h1>
		<hr>
	</div>

	<f:view>
		<h:form enctype="multipart/form-data">
			<div align="right">
				<h:commandButton value="Main Menu" action="mainMenu.jsp"
					styleClass="commonPages-commonbutton" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<h:commandButton value="Logout" action="#{logout.processLogout}"
					styleClass="commonPages-commonbutton" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<hr>
			</div>
			<div class="commonPages-text">
				<div align="center">
					<div align="center">
						<h:outputLabel value="Select file to upload:" />
						<t:inputFileUpload id="fileUpload" label="File to upload"
							storage="default" value="#{actionBeanFile.uploadedFile}"
							size="60" />
						<br /> <br />
						<h:commandButton id="upload"
							action="#{actionBeanFile.processFileUpload}" value="Submit"
							styleClass="commonPages-commonbutton" />
						<hr>
					</div>
				</div>
				<div id="errorMessage">
					<h:outputText value="#{actionBeanFile.message}"
						rendered="#{actionBeanFile.renderErrorMessage}"
						style="width:100%;  color:red" />
				</div>
				<div id="textArea">
					<h:panelGrid>
						<h:outputText value="Script File Display"
							rendered="#{actionBeanFile.renderTextArea}" />
					</h:panelGrid>
					<h:inputTextarea rows="6" cols="40" style="height:100px"
						value="#{actionBeanFile.input}"
						rendered="#{actionBeanFile.renderTextArea}" />
					<br /> <br />
					<h:commandButton id="next"
						action="#{actionBeanFile.nextInputAction}" value="Next"
						rendered="#{actionBeanFile.renderTextArea}"
						styleClass="commonPages-commonbutton" />
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<h:commandButton id="execute"
						action="#{actionBeanFile.processInputAction}" value="Execute"
						rendered="#{actionBeanFile.renderTextArea}"
						styleClass="commonPages-commonbutton" />
					<hr />
				</div>
				<div>
					<h:panelGrid columns="1">
						<h:outputText value="Table List"
							rendered="#{actionBeanFile.renderTablename}" />
						<h:selectOneListbox id="selectOneCb"
							value="#{dbOperations.tableSelected}"
							rendered="#{actionBeanFile.renderTablename}" size="5">
							<f:selectItems value="#{dbOperations.tableList}" />
						</h:selectOneListbox>
						<h:outputText value="Column List"
							rendered="#{actionBeanFile.renderColumnNames}" />
						<h:selectManyListbox id="selectcolumns"
							value="#{dbOperations.columnSelected}"
							rendered="#{actionBeanFile.renderColumnNames}" size="10">
							<f:selectItems value="#{dbOperations.columnsList}" />
						</h:selectManyListbox>
					</h:panelGrid>
					<h:outputText value="Query : "
						rendered="#{actionBeanFile.renderTableDetails}" />
					<h:outputText value="#{dbOperations.userQuery}"
						rendered="#{actionBeanFile.renderTableDetails}" />
					<br />
					<h:outputText value="Rows : "
						rendered="#{actionBeanFile.renderTableDetails}" />
					<h:outputText value="#{dbOperations.rowsAffected}"
						rendered="#{actionBeanFile.renderTableDetails}" />
					<br />
					<h:outputText value="Columns : "
						rendered="#{actionBeanFile.renderTableDetails}" />
					<h:outputText value="#{dbOperations.columnCount}"
						rendered="#{actionBeanFile.renderTableDetails}" />
					<hr />
				</div>
				<div align="center">
					<h:graphicImage value="#{graphics.histPath}" width="600"
						height="600" rendered="#{actionBeanFile.renderHistChart}" />
					<h:graphicImage value="#{graphics.xyChartPath}" width="600"
						height="600" rendered="#{actionBeanFile.renderSPChart}" />
				</div>
				<div
					style="background-attachment: scroll; overflow: auto; height: 300px; background-repeat: repeat">
					<t:dataTable value="#{dbOperations.result}" var="row"
						rendered="#{actionBeanFile.renderTabledata}" border="1">
						<t:columns var="col" value="#{dbOperations.columnSelected}">
							<f:facet name="header">
								<t:outputText styleClass="outputHeader" value="#{col}" />
							</f:facet>
							<t:outputText styleClass="outputText" value="#{row[col]}" />
						</t:columns>
					</t:dataTable>
				</div>
				<div id="regression">
					<h:outputText value="Regression Results"
						rendered="#{actionBeanFile.renderRegressionResults}"
						styleClass="commonPages-h1" />
					<br />
					<h:outputText value="Regression Equation: "
						rendered="#{actionBeanFile.renderRegressionResults}">
					</h:outputText>
					<h:outputText value="#{regression.regressionEquation}"
						rendered="#{actionBeanFile.renderRegressionResults}">
					</h:outputText>
					<br /> <br />
					<h:outputText value="Regression Model"
						rendered="#{actionBeanFile.renderRegressionResults}"></h:outputText>
					<h:panelGrid columns="5"
						style="background-color: Beige;
border-bottom-style: solid;
border-top-style: solid;
border-left-style: solid;
border-right-style: solid"
						rendered="#{actionBeanFile.renderRegressionResults}" border="1">
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
						rendered="#{actionBeanFile.renderRegressionResults}" border="1">
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
						rendered="#{actionBeanFile.renderRegressionResults}" />
					<br />
					<h:panelGrid columns="6"
						rendered="#{actionBeanFile.renderRegressionResults}" border="1">
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
				</div>
				<div align=center id="correlation">
					<h:outputText value="Correlation Results"
						rendered="#{actionBeanFile.renderCorrResults}"
						styleClass="commonPages-h1" />
					<h:panelGrid columns="4"
						rendered="#{actionBeanFile.renderCorrResults}" border="2">
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
						rendered="#{actionBeanFile.renderCorrResults}" border="2">
						<h:outputText
							value="Cell Contents : Pearson Correlation (P-Value)" />
					</h:panelGrid>
				</div>
				<div
					style="background-attachment: scroll; overflow: auto; background-repeat: repeat"
					align="center" id="DescStats">
					<h:outputText value="Descriptive Stats"
						rendered="#{actionBeanFile.renderDescStatsResults}"
						styleClass="commonPages-h1" />
					<t:dataTable value="#{statisticsBean.statisticList}"
						var="rowNumber"
						rendered="#{actionBeanFile.renderDescStatsResults}" border="1"
						cellspacing="0" cellpadding="1" headerClass="headerWidth">
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
			</div>
		</h:form>
	</f:view>
</body>
</html>