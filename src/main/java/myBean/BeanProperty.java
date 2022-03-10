package myBean;

import java.awt.*;
import java.beans.BeanDescriptor;
import java.beans.EventSetDescriptor;
import java.beans.MethodDescriptor;
import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;

public class BeanProperty implements BeanAdapter, BeanInfo{
    public static Object getProperty(Object o, String propertyName) {
        if (o == null ||
                propertyName == null ||
                propertyName.length() < 1) {
            return null;
        }
        // Based on the property name build the getter method name
        Object property = null;
        try {
            Class<?> c = o.getClass();
            java.lang.reflect.Method m = c.getMethod("get", String.class);
            property = m.invoke(o, propertyName);
        } catch (NoSuchMethodException e) {
            System.out.println("No such method");
            // Handle exception
        }  catch (SecurityException e) {
            // No permission; Handle exception
        } catch (InvocationTargetException | IllegalAccessException e) {
            e.printStackTrace();
        }
        return property;
    }

    public static void setProperty(Object o, String propertyName, Object value) {
        if (!(o == null || propertyName == null || propertyName.length() < 1)) {
            // Based on the property name build the getter method name
            try {
                Class<?> c = o.getClass();
                java.lang.reflect.Method m = c.getMethod("set", String.class, Object.class);
                m.invoke(o, propertyName,value);
            } catch (NoSuchMethodException e) {
                System.out.println("No such method");
                // Handle exception
            }  catch (SecurityException e) {
                // No permission; Handle exception
            } catch (InvocationTargetException | IllegalAccessException e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public MethodDescriptor[] getMethodDescriptors() {
        return new MethodDescriptor[0];
    }

    @Override
    public BeanDescriptor getBeanDescriptor() {
        return null;
    }

    @Override
    public EventSetDescriptor[] getEventSetDescriptors() {
        return new EventSetDescriptor[0];
    }

    @Override
    public int getDefaultEventIndex() {
        return 0;
    }

    @Override
    public PropertyDescriptor[] getPropertyDescriptors() {
        return new PropertyDescriptor[0];
    }

    @Override
    public Image getIcon(int iconKind) {
        return null;
    }

    @Override
    public int getDefaultPropertyIndex() {
        return 0;
    }
}
