<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.util.FileUpload" %>
<%@ page import="com.example.dao.PostDAO" %>
<%@ page import="com.example.model.PostVO" %>

<%
    int id = Integer.parseInt(request.getParameter("id"));

    // FileUpload로 데이터 읽기
    FileUpload uploader = new FileUpload();
    PostVO newPost = uploader.uploadFile(request);

    // 기존 게시글 정보 조회
    PostDAO dao = new PostDAO();
    PostVO oldPost = dao.getPost(id);

    // 기존 정보 유지 + 새 정보 덮어쓰기
    oldPost.setTitle(newPost.getTitle());
    oldPost.setUserid(newPost.getUserid());
    oldPost.setContent(newPost.getContent());

    // 파일이 업로드되었으면 교체
    if (newPost.getFilename() != null) {
        oldPost.setFilename(newPost.getFilename());
    }

    // DB update
    dao.updatePost(oldPost);
%>

<%@ include file="top.jsp" %>

<div class="heading">Post Updated</div>

<p>The post has been successfully updated.</p>

<br>
<a href="list.jsp" class="btn-add">Back to List</a>

<%@ include file="bottom.jsp" %>
