package com.example.util;

import com.example.model.PostVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

public class FileUpload {

    public PostVO uploadFile(HttpServletRequest request) {

        int sizeLimit = 15 * 1024 * 1024;

        String realPath = request.getServletContext().getRealPath("upload");

        File dir = new File(realPath);
        if (!dir.exists()) dir.mkdirs();

        MultipartRequest multi;
        try {
            multi = new MultipartRequest(
                    request,
                    realPath,
                    sizeLimit,
                    "utf-8",
                    new DefaultFileRenamePolicy()
            );
        } catch (IOException e) {
            System.out.println("파일 업로드 실패: " + e.getMessage());
            return null;
        }

        String filename = multi.getFilesystemName("photo");
        String title = multi.getParameter("title");
        String userid = multi.getParameter("userid");
        String content = multi.getParameter("content");

        if (title == null || userid == null || content == null) {
            System.out.println("null 파라미터 감지");
            return null;
        }

        PostVO post = new PostVO();
        post.setTitle(title);
        post.setUserid(userid);
        post.setContent(content);
        post.setFilename(filename);

        return post;
    }
}
