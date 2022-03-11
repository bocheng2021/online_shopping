package Testing;

import myBean.BeanProperty;

import java.util.List;

public class Testing {
    public Testing(){}

    public void RunSimpleTest(TypeOfTest type)
    {
        User user = new User();
        if(type.equals(TypeOfTest.BeanProperty))
        {
            System.out.println("Test for BeanProperty.");
            System.out.println("Using 'setProperty' to set id.");
            BeanProperty.setProperty(user,"id",141);
            System.out.println("Using 'getProperty' to get id: "+BeanProperty.getProperty(user,"id"));
        }
        else
        {
            System.out.println("Test for BaseBean.");
            System.out.println("Using 'set' to set id.");
            user.set("id",141);
            System.out.println("Using 'get' to get id: "+user.get("id"));
        }
    }

    public void RunDatabaseTest()
    {
        DBUtilBean database=new DBUtilBean();
        String[] result_names;
        String search_input = "cookie";
        List<List> result=database.Search(search_input);
        if (result!=null)
        {
            result_names=new String[result.size()];
            for (int i=0;i<result.size();i++)
            {
                result_names[i]=((result.get(i).toString()).replace("images/category/", "").
                        replace(".png", ""));
                System.out.println(result_names[i]);
            }
        }
    }

    public static void main(String[] args) {
        Testing test = new Testing();
        test.RunSimpleTest(TypeOfTest.BaseBean);
        test.RunDatabaseTest();
    }
}
