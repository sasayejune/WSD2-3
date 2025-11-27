<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.example.dao.PostDAO" %>
<%@ page import="com.example.model.PostVO" %>
<%@ include file="top.jsp" %>

<%
    // 1) 업로드 경로 생성
    String uploadPath = request.getServletContext().getRealPath("upload");
    int sizeLimit = 15 * 1024 * 1024;

    File dir = new File(uploadPath);
    if (!dir.exists()) dir.mkdirs();

    // 2) MultipartRequest로 데이터 받기
    MultipartRequest multi = new MultipartRequest(
            request,
            uploadPath,
            sizeLimit,
            "utf-8",
            new DefaultFileRenamePolicy()
    );

    // 3) form 데이터
    String title = multi.getParameter("title");
    String userid = multi.getParameter("userid");
    String content = multi.getParameter("content");
    String filename = multi.getFilesystemName("photo");

    if (filename == null) filename = "";   // 파일 없을 때 대비

    // 4) VO에 담기
    PostVO vo = new PostVO();
    vo.setTitle(title);
    vo.setUserid(userid);
    vo.setContent(content);
    vo.setFilename(filename);

    // 5) DAO 저장
    PostDAO dao = new PostDAO();
    dao.addPost(vo);
%>

<div class="heading">Post Created</div>

<p>Your post has been successfully saved.</p>

<br>
<!-- ✔ JSP OK 방식에서는 JSP 파일 직접 이동 -->
<a href="list.jsp" class="btn-add">Go to List</a>

<%@ include file="bottom.jsp" %>
