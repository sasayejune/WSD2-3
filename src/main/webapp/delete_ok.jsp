<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.dao.PostDAO" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));

    PostDAO dao = new PostDAO();
    dao.deletePost(id);
%>

<%@ include file="top.jsp" %>

<div class="heading">Delete Complete</div>

<p style="font-size:16px;">
    The post has been successfully deleted.
</p>

<br>
<a class="btn-add" href="list.jsp">Back to List</a>

<%@ include file="bottom.jsp" %>
