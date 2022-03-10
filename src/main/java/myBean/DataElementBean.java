package myBean;

public class DataElementBean extends BaseBean{
    /*
    private enum DataTypeValue{TINYINT,SMALLINT,MEDIUMINT,INT,INTEGER,BIGINT,FLOAT,DOUBLE,DECIMAL};
    private enum DataTypeDate{DATE,TIME,YEAR,DATETIME,TIMESTAMP};
    private enum DataTypeString{CHAR,VARCHAR,TINYBLOB,TINYTEXT,BLOB,TEXT,MEDIUMBLOB,MEDIUMTEXT,LONGBLOB,LONGTEXT};
    */
    private String DataType;
    private String DataName;
    private String DataValue;
    private String defaultValue;
    private boolean isProvided;
    private boolean isRequired;
    private boolean isInitialised;

    public DataElementBean()
    {
        this.DataName = null;
        this.DataType = null;
        this.DataValue = null;
        this.defaultValue = null;
        this.isProvided = false;
        this.isRequired = false;
        this.isInitialised = false;
    }

}
