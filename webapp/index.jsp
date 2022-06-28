<%
session.setAttribute("signIn", false);
request.getRequestDispatcher("main.view").forward(request, response);
%>
