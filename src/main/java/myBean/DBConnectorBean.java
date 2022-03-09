package myBean;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnectorBean extends BaseBean{
    private String databaseAddress;
    private String databaseUsername;
    private String databasePassword;

    public DBConnectorBean() {}
    /**
     * Connect to local database and return the conenction.
     */
    public static Connection getLocalConnection(String databaseAddress,
                                                String databaseUsername,
                                                String databasePassword)
    {
        //Modify the following code for your own MySql database.
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
                /* ignore close errors */
                System.err.println("Database cannot be closed!");
                e.printStackTrace();
            }
        }
    }
}
