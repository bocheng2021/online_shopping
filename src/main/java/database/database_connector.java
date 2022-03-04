package database;

import java.sql.Connection;
import java.sql.DriverManager;

public class database_connector {
    /**
     * Connect to local database and return the conenction.
     */
    public static Connection getLocalConnection() {
        //Modify the following code for your own MySql database.
        String databaseAddress;
        String databaseUsername;
        String databasePassword;
        databaseAddress = "jdbc:mysql://localhost:3306/DDBMS?serverTimezone=UTC";
        databaseUsername = "root";
        databasePassword = "ybc1234";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver").newInstance();

            Connection connection = DriverManager.getConnection(databaseAddress, databaseUsername, databasePassword);
            System.out.println("Database connected.");
            return connection;
        } catch (Exception e) {
            System.err.println("Database cannot be connected!");
            return null;
        }
    }

    public void close(Connection c) {
        if (c != null) {
            try {
                c.close();
                System.out.println("Database connection closed.");
            } catch (Exception e) {
                /* ignore close errors */
                System.err.println("Database cannot be closed!");
                e.printStackTrace();
            }
        }
    }
}
