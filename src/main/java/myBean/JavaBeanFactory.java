package myBean;

public class JavaBeanFactory {
    public <T> Class<T> generate(Class<T> clazz) {
        // I used here CGLIB to generate dynamically a class that implements the methods:
        // getters
        // setters
        // addPropertyChangeListener
        // removePropertyChangeListener
        return null;
    }
}
