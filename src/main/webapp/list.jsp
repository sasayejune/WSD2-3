<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="top.jsp" %>

<div class="heading">자유게시판</div>

<!-- Search + Add toolbar -->
<div class="toolbar">
    <form method="get" action="${pageContext.request.contextPath}/post/list" style="display:flex;">
        <input type="text" name="keyword" placeholder="Search..." value="${param.keyword}">
        <input type="submit" value="검색" class="btn-add" style="margin-right:10px;">
    </form>

    <a href="${pageContext.request.contextPath}/post/write" class="btn-add">Add</a>
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
                <a href="${pageContext.request.contextPath}/post/view?id=${post.id}">
                        ${post.title}
                </a>
            </td>
            <td>${post.userid}</td>
            <td>${post.regdate}</td>
            <td>
                <a href="${pageContext.request.contextPath}/post/edit?id=${post.id}" class="icon-btn">✏️</a>
                <a href="${pageContext.request.contextPath}/post/delete?id=${post.id}"
                   class="icon-btn" onclick="return confirm('정말 삭제하시겠습니까?');">🗑️</a>
            </td>
        </tr>
    </c:forEach>
</table>

<%@ include file="bottom.jsp" %>
