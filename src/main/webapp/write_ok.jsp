<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.util.FileUpload" %>
<%@ page import="com.example.model.PostVO" %>
<%@ page import="com.example.dao.PostDAO" %>
<%@ include file="top.jsp" %>

<%
    FileUpload uploader = new FileUpload();
    PostVO vo = uploader.uploadFile(request);

    if (vo == null) {
        out.println("<h3>파일 업로드 중 오류가 발생했습니다.</h3>");
        return;
    }


    PostDAO dao = new PostDAO();
    dao.addPost(vo);
%>

<div class="heading">Post Created</div>

<p>Your post has been successfully saved.</p>

<a href="list.jsp" class="btn-add">Back to List</a>

<%@ include file="bottom.jsp" %>
