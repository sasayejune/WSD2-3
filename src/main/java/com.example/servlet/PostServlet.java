package com.example.servlet;

import com.example.dao.PostDAO;
import com.example.model.PostVO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/post/*")  // /post/list, /post/view, /post/write 등 처리
public class PostServlet extends HttpServlet {

    private PostDAO postDAO = new PostDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getPathInfo();  // /list, /view 등

        // action이 null인 경우 → 기본 list로 이동
        if (action == null || action.equals("/")) {
            response.sendRedirect(request.getContextPath() + "/post/list");
            return;
        }

        switch (action) {
            case "/list": {
                String keyword = request.getParameter("keyword");

                List<PostVO> posts;
                if (keyword != null && !keyword.isEmpty()) {
                    posts = postDAO.searchPosts(keyword);
                } else {
                    posts = postDAO.listPosts();
                }

                request.setAttribute("posts", posts);
                request.getRequestDispatcher("/list.jsp").forward(request, response);
                break;
            }

            case "/view": {
                int id = Integer.parseInt(request.getParameter("id"));
                PostVO post = postDAO.getPost(id);
                request.setAttribute("post", post);
                request.getRequestDispatcher("/view.jsp").forward(request, response);
                break;
            }

            case "/write": {
                // 단순 작성 페이지 이동
                request.getRequestDispatcher("/write.jsp").forward(request, response);
                break;
            }

            case "/edit": {
                int id = Integer.parseInt(request.getParameter("id"));
                PostVO post = postDAO.getPost(id);
                request.setAttribute("post", post);
                request.getRequestDispatcher("/edit.jsp").forward(request, response);
                break;
            }

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getPathInfo();

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/post/list");
            return;
        }

        switch (action) {

            case "/write": {
                String title = request.getParameter("title");
                String userid = request.getParameter("userid");
                String content = request.getParameter("content");

                PostVO post = new PostVO();
                post.setTitle(title);
                post.setUserid(userid);
                post.setContent(content);

                postDAO.addPost(post);
                response.sendRedirect(request.getContextPath() + "/post/list");
                break;
            }

            case "/edit": {
                int id = Integer.parseInt(request.getParameter("id"));
                String title = request.getParameter("title");
                String userid = request.getParameter("userid");
                String content = request.getParameter("content");

                PostVO post = new PostVO();
                post.setId(id);
                post.setTitle(title);
                post.setUserid(userid);
                post.setContent(content);

                postDAO.updatePost(post);
                response.sendRedirect(request.getContextPath() + "/post/list");
                break;
            }

            case "/delete": {
                int id = Integer.parseInt(request.getParameter("id"));
                postDAO.deletePost(id);
                response.sendRedirect(request.getContextPath() + "/post/list");
                break;
            }

            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
