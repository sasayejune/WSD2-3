<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>게시판</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

</head>
<body>

<!-- NAVBAR -->
<div class="navbar">
    <div class="nav-left">
        <a href="${pageContext.request.contextPath}/post/list" style="color:#333; text-decoration:none;">
            게시판
        </a>
    </div>

    <div class="nav-right">
        <a href="${pageContext.request.contextPath}/post/list">목록</a>
        <a href="${pageContext.request.contextPath}/post/write">글쓰기</a>
    </div>
</div>

<!-- 페이지 내용 시작 -->
<div class="content-wrapper">
