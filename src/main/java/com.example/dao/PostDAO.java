package com.example.dao;

import com.example.model.PostVO;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import static com.example.util.JDBCUtil.getConnection;

public class PostDAO {

    // 전체 목록 조회
    public List<PostVO> listPosts() {
        List<PostVO> posts = new ArrayList<>();
        String sql = "SELECT * FROM post ORDER BY id DESC";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                PostVO post = new PostVO();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setUserid(rs.getString("userid"));
                post.setContent(rs.getString("content"));
                post.setRegdate(rs.getString("regdate"));
                post.setFilename(rs.getString("filename"));   // ★ 추가됨
                post.setCnt(rs.getInt("cnt"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return posts;
    }

    // 글 추가
    public void addPost(PostVO post) {
        String sql = "INSERT INTO post (title, userid, content, filename, regdate) VALUES (?, ?, ?, ?, NOW())";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getUserid());
            pstmt.setString(3, post.getContent());
            pstmt.setString(4, post.getFilename());   // ★ 추가됨

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 글 수정
    public void updatePost(PostVO post) {
        String sql = "UPDATE post SET title = ?, userid = ?, content = ?, filename = ? WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, post.getTitle());
            pstmt.setString(2, post.getUserid());
            pstmt.setString(3, post.getContent());
            pstmt.setString(4, post.getFilename());     // ★ 추가됨
            pstmt.setInt(5, post.getId());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 글 삭제
    public void deletePost(int id) {
        String sql = "DELETE FROM post WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 글 상세 조회
    public PostVO getPost(int id) {
        PostVO post = null;
        String sql = "SELECT * FROM post WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                post = new PostVO();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setUserid(rs.getString("userid"));
                post.setContent(rs.getString("content"));
                post.setRegdate(rs.getString("regdate"));
                post.setFilename(rs.getString("filename"));
                post.setCnt(rs.getInt("cnt"));

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return post;
    }

    // 검색 기능
    public List<PostVO> searchPosts(String keyword) {
        List<PostVO> posts = new ArrayList<>();
        String sql = "SELECT * FROM post WHERE title LIKE ? OR content LIKE ? ORDER BY id DESC";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, "%" + keyword + "%");
            pstmt.setString(2, "%" + keyword + "%");

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                PostVO post = new PostVO();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setUserid(rs.getString("userid"));
                post.setContent(rs.getString("content"));
                post.setRegdate(rs.getString("regdate"));
                post.setFilename(rs.getString("filename"));
                post.setCnt(rs.getInt("cnt"));

                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return posts;
    }

    public void updateCount(int id) {
        String sql = "UPDATE post SET cnt = cnt + 1 WHERE id = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, id);
            pstmt.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public List<PostVO> listPostsSorted(String sort) {
        List<PostVO> posts = new ArrayList<>();

        String sql = "SELECT * FROM post";

        if ("cnt".equals(sort)) {
            sql += " ORDER BY cnt DESC";
        } else if ("title".equals(sort)) {
            sql += " ORDER BY title ASC";
        } else if ("old".equals(sort)) {
            sql += " ORDER BY id ASC";
        } else {
            sql += " ORDER BY id DESC"; // 기본 최신순(new)
        }

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                PostVO post = new PostVO();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setUserid(rs.getString("userid"));
                post.setContent(rs.getString("content"));
                post.setRegdate(rs.getString("regdate"));
                post.setFilename(rs.getString("filename"));
                post.setCnt(rs.getInt("cnt"));
                posts.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return posts;
    }


    public List<PostVO> filterByUser(String userid) {
        List<PostVO> posts = new ArrayList<>();

        String sql = "SELECT * FROM post WHERE userid = ? ORDER BY id DESC";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, userid);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                PostVO post = new PostVO();
                post.setId(rs.getInt("id"));
                post.setTitle(rs.getString("title"));
                post.setUserid(rs.getString("userid"));
                post.setContent(rs.getString("content"));
                post.setRegdate(rs.getString("regdate"));
                post.setFilename(rs.getString("filename"));
                post.setCnt(rs.getInt("cnt"));
                posts.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return posts;
    }


}
