package myBean;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.awt.*;
import java.beans.*;
import java.beans.beancontext.BeanContext;
import java.io.IOException;
import java.lang.reflect.Field;

public class WebBean extends MyBean{
    private ServletRequest request;
    private ServletResponse response;
    private final Field[] fields = this.getClass().getDeclaredFields();
    private final PropertyChangeSupport changes = new PropertyChangeSupport(this);


    public Object getAttribute(String name) {
        return this.request.getAttribute(name);
    }

    public String getParameter(String name) {
        return this.request.getParameter(name);
    }
    public ServletResponse getResponse()
    {
        return this.response;
    }

    public void setRequest(ServletRequest request) {
        if (request == null) {
            throw new IllegalArgumentException("Request cannot be null.");
        } else {
            this.request = request;
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

    @Override
    public Object instantiate(ClassLoader cls, String beanName) throws IOException, ClassNotFoundException {
        return null;
    }

    @Override
    public Object instantiate(ClassLoader cls, String beanName, BeanContext beanContext) throws IOException, ClassNotFoundException {
        return null;
    }

    @Override
    public Object instantiate(ClassLoader cls, String beanName, BeanContext beanContext, AppletInitializer initializer) throws IOException, ClassNotFoundException {
        return null;
    }

    @Override
    public Object getInstanceOf(Object bean, Class<?> targetType) {
        return null;
    }

    @Override
    public boolean isInstanceOf(Object bean, Class<?> targetType) {
        return false;
    }

    @Override
    public void set(String name, Object a) {
        for (Field field : fields) {
            // For each property, get the property name
            String varName = field.getName();
            try {
                boolean access = field.isAccessible();
                if (!access) field.setAccessible(true);
                if (varName.equals(name))
                {
                    Object old_value = field.get(this);
                    changes.firePropertyChange(name, old_value, a);
                    field.set(this, a);
                }
                if (!access) field.setAccessible(false);
            } catch (Exception ex) {
                System.out.println("Wrong input type or value.");
            }
        }
    }

    @Override
    public Object get(String name) {
        Object result = null;
        for (Field field : fields) {
            // For each property, get the property name
            String varName = field.getName();
            try {
                boolean access = field.isAccessible();
                if (!access) field.setAccessible(true);
                if (name.equals(varName))
                {
                    result = field.get(this);
                }
                if (!access) field.setAccessible(false);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
        return result;
    }

    @Override
    public String[] variableName() {
        return new String[0];
    }

    @Override
    public void addPropertyChangeListener(PropertyChangeListener listener) {

    }

    @Override
    public void removePropertyChangeListener(PropertyChangeListener listener) {

    }
}
