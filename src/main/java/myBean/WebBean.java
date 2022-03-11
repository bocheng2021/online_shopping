package myBean;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import java.beans.*;
import java.lang.reflect.Field;

public class WebBean extends BaseBean{
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
}
