package Testing;

import myBean.BaseBean;

public class User extends BaseBean {

    // Properties.
    private int id;
    private String User_Name;
    private String Password;
    private double Money;
    private String defaultAddress;
    private int User_Identity;

    public boolean equals(User user)
    {
        return user.get("id").equals(this.get("id")) || user.get("User_Name").equals(this.get("User_Name"));
    }

    public String toString() {
        return String.format("Testing.User[id=%d,name=%s,birthdate=%s]", id, User_Name, Money);
    }


}
