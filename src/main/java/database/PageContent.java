package database;
import java.util.Arrays;

public class PageContent {
    public String[] getPageName(String pageNum)
    {
        String[] names=new String[6];
        Arrays.fill(names, "");
        switch (pageNum) {
            case "2":
                names[0] = ("012");
                names[1] = ("014");
                names[2] = ("022");
                names[3] = ("024");
                names[4] = ("032");
                names[5] = ("034");
                break;
            case "3":
                names[0] = ("015");
                names[1] = ("025");
                names[2] = ("035");
                names[3] = ("111");
                names[4] = ("112");
                names[5] = ("113");
                break;
            case "4":
                names[0] = ("114");
                names[1] = ("115");
                names[2] = ("121");
                names[3] = ("122");
                names[4] = ("123");
                names[5] = ("124");
                break;
            case "5":
                names[0] = ("125");
                names[1] = ("131");
                names[2] = ("132");
                names[3] = ("133");
                names[4] = ("134");
                names[5] = ("135");
                break;
            case "6": {
                int a = 211;
                for (int i = 0; i < names.length; i++) {
                    if (i <= 4) {
                        names[i] = (String.valueOf(a + i));
                    } else {
                        names[i] = (String.valueOf(221));
                    }
                }
                break;
            }
            case "7": {
                int a = 222;
                for (int i = 0; i < names.length; i++) {
                    if (i <= 3) {
                        names[i] = (String.valueOf(a + i));
                    } else {
                        names[i] = (String.valueOf(227 + i));
                    }
                }
                break;
            }
            case "1":
            default:
                names[0] = ("011");
                names[1] = ("013");
                names[2] = ("021");
                names[3] = ("023");
                names[4] = ("031");
                names[5] = ("033");
                break;
        }
        return names;
    }

    public String getMenuName(String name)
    {
        String result="";
        switch(name)
        {
            case "01":
                result="Chips";
                break;
            case "02":
                result="Cookie";
                break;
            case "03":
                result="Chocolate";
                break;
            case "11":
                result="Milk";
                break;
            case "12":
                result="Soft drinks";
                break;
            case "13":
                result="Wine";
                break;
            case "21":
                result="Toothpaste and toothbrush";
                break;
            case "22":
                result="Bath Supplies";
                break;
            case "23":
                result="Facial Care";
                break;
        }
        return result;
    }
}
