package myBean;

import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DatabaseBean extends BaseBean{
    private String query;
    private ResultSet rs;
    private List<List> result;
    public DatabaseBean() {}

    /**
     * @param rset JDBC ResultSet.
     * @return List of Lists containing the elements of a table
     */
    public List<List> getResult(ResultSet rset) {
        List<List> result = new ArrayList<>();
        List<String> row;
        try {
            int colNum = rset.getMetaData().getColumnCount();
            while (rset.next()) {
                row = new ArrayList<String>();
                for (int i = 1; i <= colNum; i++) {
                    row.add(rset.getString(i));
                }
                result.add(row);
            }
            return result;
        } catch (Exception e) {
            System.err.println("Error in retrieving data.");
        }
        return null;
    }

    public Connection getConnection()
    {
        return DBConnectorBean.getLocalConnection();
    }

}
