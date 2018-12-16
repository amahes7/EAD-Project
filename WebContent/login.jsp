<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsf/core"%>
<%@ taglib prefix="h" uri="http://java.sun.com/jsf/html"%>
<%@ taglib prefix="t" uri="http://myfaces.apache.org/tomahawk"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<link rel="stylesheet" type="text/css" href="css/styles.css">
	<title>Login</title>
</head>
<body background="images/third.jpg">
	<f:view>
		<h:form>
			<div class="login">
				<div class="login-title">
					<h2>Database Login</h2>
				</div>
				<h:outputText id="errorMessage" value="#{dbAccess.message}"
					style="width:100%;  color:red" />
				<br />
				<h:panelGrid columns="3" id="p">

					<h:outputLabel value="Username* :" styleClass="login-output" />
					<h:inputText id="username" value="#{dbAccess.username}"
						required="true" requiredMessage="Username Required"
						styleClass="login-input" />
					<h:message for="username" style="color:red" />

					<h:outputLabel value="Password* :" styleClass="login-output" />
					<h:inputSecret id="password" value="#{dbAccess.password}"
						required="true" requiredMessage="Password Required"
						styleClass="login-input" />
					<h:message for="password" style="color:red" />

					<h:outputLabel value="Database* :" styleClass="login-output" />
					<h:selectOneMenu id="database" value="#{dbAccess.dbms}"
						styleClass="login-dropdown" required="true"
						requiredMessage="Database Required">
						<f:selectItem itemValue="mysql" itemLabel="MySQL" />
						<f:selectItem itemValue="db2" itemLabel="DB2" />
						<f:selectItem itemValue="oracle" itemLabel="Oracle" />
					</h:selectOneMenu>
					<h:message for="database" style="color:red" />

					<h:outputLabel value="Server* :" styleClass="login-output" />
					<h:selectOneMenu id="server" value="#{dbAccess.host}"
						styleClass="login-dropdown" required="true"
						requiredMessage="server Required">
						<f:selectItem itemValue="131.193.209.68" itemLabel="server68" />
						<f:selectItem itemValue="localhost" itemLabel="localhost" />
						<f:selectItem itemValue="131.193.209.69" itemLabel="server69" />
					</h:selectOneMenu>
					<h:message for="database" style="color:red" />

					<h:outputLabel value="Schema* :" styleClass="login-output" />
					<h:inputText id="schema" value="#{dbAccess.schema}" required="true"
						requiredMessage="Schema Required" styleClass="login-input" />
					<h:message for="schema" style="color:red" />
				</h:panelGrid>
				<div align="center">
					<h:commandButton value="Login" action="#{logout.processLogin}"
						styleClass="login-button" />
				</div>
			</div>
		</h:form>
	</f:view>
</body>
</html>