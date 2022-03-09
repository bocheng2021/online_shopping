package myBean;

import java.lang.reflect.Field;
import java.util.ArrayList;

public class BeanProperty {
    public static ArrayList<String> getObjName(Object obj) {
        // Get all property fields of object obj
        Field[] fields = obj.getClass().getDeclaredFields();
        ArrayList<String> varNames = new ArrayList<>();
        for (Field field : fields) {
            // For each property, get the property name
            String varName = field.getName();
            try {
                boolean access = field.isAccessible();
                if (!access) field.setAccessible(true);
                varNames.add(varName);

                if (!access) field.setAccessible(false);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return varNames;
    }
}
