<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.dao.PostDAO" %>
<%@ page import="com.example.model.PostVO" %>

<%
    // DAO에서 목록 불러오기
    PostDAO dao = new PostDAO();

    List<PostVO> posts = null;

    // 검색 키워드 처리
    String keyword = request.getParameter("keyword");
    if (keyword != null && !keyword.trim().equals("")) {
        posts = dao.searchPosts(keyword);
    } else {
        posts = dao.listPosts();
    }

    request.setAttribute("posts", posts);
%>

<%@ include file="top.jsp" %>

<div class="heading">자유게시판</div>


<!-- Search + Add toolbar -->
<div class="toolbar">
    <form method="get" action="list.jsp" style="display:flex;">
        <input type="text" name="keyword" placeholder="Search..." value="${param.keyword}">
        <input type="submit" value="검색" class="btn-add" style="margin-right:10px;">
    </form>

    <a href="write.jsp" class="btn-add">Add</a>
</div>

<table>
    <tr>
        <th>#</th>
        <th>제목</th>
        <th>작성자</th>
        <th>등록일</th>
        <th>Menu</th>
    </tr>

    <c:forEach var="post" items="${posts}">
        <tr>
            <td>${post.id}</td>
            <td>
                <a href="view.jsp?id=${post.id}">
                        ${post.title}
                </a>
            </td>
            <td>${post.userid}</td>
            <td>${post.regdate}</td>
            <td>
                <a href="edit.jsp?id=${post.id}" class="icon-btn">✏️</a>

                <!-- delete는 삭제 확인 후 delete_ok.jsp로 이동 -->
                <a href="delete_ok.jsp?id=${post.id}"
                   class="icon-btn"
                   onclick="return confirm('정말 삭제하시겠습니까?');">
                    🗑️
                </a>
            </td>
        </tr>
    </c:forEach>
</table>

<%@ include file="bottom.jsp" %>
