package myBean;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnectorBean extends BaseBean{
    private static String databaseAddress = "jdbc:mysql://localhost:3306/DDBMS?serverTimezone=UTC";
    private static String databaseUsername = "root";
    private static String databasePassword = "ybc1234";

    public DBConnectorBean() {}
    /**
     * Connect to local database and return the conenction.
     */
    public static Connection getLocalConnection()
    {
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

    public void close (Connection c) {
        if (c != null) {
            try {
                c.close();
                System.out.println("Database connection closed.");
            } catch (Exception e) {
                System.err.println("Database cannot be closed!");
                e.printStackTrace();
            }
        }
    }
}
