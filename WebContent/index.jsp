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
<title>Index</title>
</head>
<body background="images/first.jpg">
	<f:view>
		<h:form>
			<div class="homepage-h1">
				<h1>G312 - EAD Project</h1>
				<h1>
					Abhijeet Maheshwari<br/>Ankita Singla <br/>Sheethal Sridhar <br/>
				</h1>
			</div>
			<div align="center">
				<h:commandButton value="Login" action="login.jsp"
					styleClass="homepage-button" />
			</div>
		</h:form>
	</f:view>
</body>
</html>