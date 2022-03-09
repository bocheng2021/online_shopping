package myBean;

abstract class MyBean implements java.io.Serializable, iListener, BeanInfo, BeanInit{
    public MyBean() {}
    public abstract void set(String name, Object a);
    public abstract Object get(String name);
    public abstract String[] variableName();
}