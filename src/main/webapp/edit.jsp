<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.dao.PostDAO" %>
<%@ page import="com.example.model.PostVO" %>

<%
    // 글 번호 체크
    String idParam = request.getParameter("id");
    int id = Integer.parseInt(idParam);

    // DAO로 불러오기
    PostDAO dao = new PostDAO();
    PostVO post = dao.getPost(id);

    request.setAttribute("post", post);
%>

<%@ include file="top.jsp" %>

<div class="heading">Edit Post</div>

<form action="edit_ok.jsp?id=${post.id}"
      method="POST"
      enctype="multipart/form-data">

    <p>Title</p>
    <input type="text" name="title" value="${post.title}" required>

    <p>Writer (User ID)</p>
    <input type="text" name="userid" value="${post.userid}" required>

    <p>Content</p>
    <textarea name="content" rows="6" required>${post.content}</textarea>

    <!-- 기존 파일 표시 -->
    <c:if test="${not empty post.filename}">
        <p>현재 업로드 파일:
            <strong>${post.filename}</strong>
        </p>
    </c:if>

    <!-- 새 파일 업로드 -->
    <p>새 파일 업로드(선택)</p>
    <input type="file" name="photo">

    <input type="submit" value="Save Changes">
</form>

<%@ include file="bottom.jsp" %>
