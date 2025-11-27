<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="top.jsp" %>

<div class="heading">Post Details</div>

<!-- Title -->
<h2 style="margin-bottom:5px;">${post.title}</h2>

<!-- Meta Info -->
<p style="color:#666; margin-top:0;">
    Writer: <strong>${post.userid}</strong>
    &nbsp;&nbsp; | &nbsp;&nbsp;
    Date: <strong>${post.regdate}</strong>
</p>

<hr style="margin:20px 0;">

<!-- Content -->
<p style="line-height:1.7; white-space:pre-wrap;">
    ${post.content}
</p>

<br>

<!-- Buttons -->
<a class="btn-add"
   href="${pageContext.request.contextPath}/post/edit?id=${post.id}">
    Edit
</a>

&nbsp;

<a class="btn-add"
   href="${pageContext.request.contextPath}/post/delete?id=${post.id}"
   onclick="return confirm('정말 삭제하시겠습니까?');">
    Delete
</a>

<br><br>

<a href="${pageContext.request.contextPath}/post/list">Back to List</a>

<%@ include file="bottom.jsp" %>
