package com.example.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBCUtil {
    private static Connection con = null;

    public static Connection getConnection() {
        try {
            if (con == null || con.isClosed()) {
                Class.forName("org.mariadb.jdbc.Driver");

                con = DriverManager.getConnection(
                        "jdbc:mariadb://walab.handong.edu:3306/W25_22300155",
                        "W25_22300155",
                        "Xiz5be"
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }

    public static void closeConnection() {
        try {
            if (con != null && !con.isClosed()) {
                con.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
