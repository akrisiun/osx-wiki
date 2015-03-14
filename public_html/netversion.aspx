<%@ Page Language="C#" %>
<html>
<head>
   <title>.NET version</title>
</head>
<body>
<h4>.NET version</h4>
<%
    var Response = System.Web.HttpContext.Current.Response;
    Response.Write("Assemblies=" + System.AppDomain.CurrentDomain.GetAssemblies().Length.ToString());
    foreach (var asm in System.AppDomain.CurrentDomain.GetAssemblies())
    {
        try
        {
            Response.Write("<br/>" + asm.CodeBase.Replace("file:///", ""));
        }
        catch
        {
            // case: Anonymously Hosted DynamicMethods Assembly
            Response.Write("<br/>" + asm.FullName);
        }
    }
	
	try
    {
	   Response.Write("<br/>AppDomain.BaseDirectory=" + System.AppDomain.CurrentDomain.BaseDirectory);
	}
	catch (Exception ex) {
            Response.Write("<br/>error:" + ex.Message);
    }
%>
</body>
</html>
