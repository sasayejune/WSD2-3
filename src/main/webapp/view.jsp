<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.dao.PostDAO" %>
<%@ page import="com.example.model.PostVO" %>

<%
    // ---- 1) 글 번호 받아오기 ----
    String idParam = request.getParameter("id");
    int id = Integer.parseInt(idParam);

    // ---- 2) DAO로 글 데이터 조회 ----
    PostDAO dao = new PostDAO();
    PostVO post = dao.getPost(id);

    // ---- 3) request에 post 저장 (EL 사용 위해) ----
    request.setAttribute("post", post);
%>

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

<c:if test="${not empty post.filename}">
    <!-- 이미지 보여주기 -->
    <img src="upload/${post.filename}" style="max-width:400px; margin-bottom:20px;">
    <br>

    <!-- 다운로드 버튼 -->
    <a href="upload/${post.filename}" download class="btn-add">
        📥 Download File
    </a>
    <br><br>
</c:if>


<!-- Content -->
<p style="line-height:1.7; white-space:pre-wrap;">
    ${post.content}
</p>

<br>

<!-- Buttons -->
<a class="btn-add" href="edit.jsp?id=${post.id}">
    Edit
</a>

&nbsp;

<a class="btn-add"
   href="delete_ok.jsp?id=${post.id}"
   onclick="return confirm('정말 삭제하시겠습니까?');">
    Delete
</a>

<br><br>

<a href="list.jsp">Back to List</a>

<%@ include file="bottom.jsp" %>
