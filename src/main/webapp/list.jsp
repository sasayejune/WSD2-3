<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.dao.PostDAO" %>
<%@ page import="com.example.model.PostVO" %>

<%
    PostDAO dao = new PostDAO();
    List<PostVO> posts = null;

    String keyword = request.getParameter("keyword");
    String sort = request.getParameter("sort");
    String uid = request.getParameter("userid");   // ★ 작성자 필터 추가

    if (uid != null && !uid.trim().equals("")) {         // ★ 1순위: 작성자 필터
        posts = dao.filterByUser(uid);

    } else if (keyword != null && !keyword.trim().equals("")) { // 2순위: 검색
        posts = dao.searchPosts(keyword);

    } else {                                             // 3순위: 정렬 or 전체 목록
        posts = dao.listPostsSorted(sort);
    }

    request.setAttribute("posts", posts);
%>


<%@ include file="top.jsp" %>

<div class="heading">자유게시판</div>

<!-- 정렬 UI 추가 -->
<form method="get" action="list.jsp" style="margin-bottom: 20px;">
    <select name="sort">
        <option value="new"   <%= "new".equals(sort)   ? "selected" : "" %>>최신순</option>
        <option value="old"   <%= "old".equals(sort)   ? "selected" : "" %>>오래된순</option>
        <option value="cnt"   <%= "cnt".equals(sort)   ? "selected" : "" %>>조회수순</option>
        <option value="title" <%= "title".equals(sort) ? "selected" : "" %>>제목순</option>
    </select>
    <input type="submit" value="정렬" class="btn-add">
</form>

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

            <td>
                <a href="list.jsp?userid=${post.userid}">
                        ${post.userid}
                </a>
            </td>

            <td>${post.regdate}</td>
            <td>
                <a href="edit.jsp?id=${post.id}" class="icon-btn">✏️</a>

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
