<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="top.jsp" %>

<div class="heading">Create New Post</div>

<form action="write_ok.jsp"
      method="post"
      enctype="multipart/form-data">

    <p>Title</p>
    <input type="text" name="title" required>

    <p>Writer (User ID)</p>
    <input type="text" name="userid" required>

    <p>Content</p>
    <textarea name="content" rows="6" required></textarea>

    <p>Upload Image</p>
    <input type="file" name="photo">

    <input type="submit" value="Submit">
</form>

<%@ include file="bottom.jsp" %>
