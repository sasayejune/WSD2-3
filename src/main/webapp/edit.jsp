<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="top.jsp" %>

<div class="heading">Edit Post</div>

<form action="${pageContext.request.contextPath}/post/edit" method="POST">

    <input type="hidden" name="id" value="${post.id}">

    <p>Title</p>
    <input type="text" name="title" value="${post.title}" required>

    <p>Writer (User ID)</p>
    <input type="text" name="userid" value="${post.userid}" required>

    <p>Content</p>
    <textarea name="content" rows="6" required>${post.content}</textarea>

    <input type="submit" value="Save Changes">
</form>

<%@ include file="bottom.jsp" %>
