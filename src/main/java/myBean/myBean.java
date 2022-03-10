package myBean;

import java.beans.PropertyChangeListener;

abstract class MyBean implements java.io.Serializable, iListener, BeanInfo, BeanInit, BeanAdapter, Getter, Setter{
    public MyBean() {}
    public abstract void set(String name, Object a);
    public abstract Object get(String name);
    public abstract String[] variableName();
    public abstract void addPropertyChangeListener( PropertyChangeListener listener );
    public abstract void removePropertyChangeListener( PropertyChangeListener listener );
}