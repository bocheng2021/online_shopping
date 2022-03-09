package myBean;

import java.beans.AppletInitializer;
import java.beans.beancontext.BeanContext;
import java.io.IOException;

public interface BeanInit {
    Object instantiate(ClassLoader cls, String beanName) throws IOException, ClassNotFoundException;
    Object instantiate(ClassLoader cls, String beanName,
                                       BeanContext beanContext) throws IOException, ClassNotFoundException;
    Object instantiate(ClassLoader cls, String beanName,
                                       BeanContext beanContext, AppletInitializer initializer)
            throws IOException, ClassNotFoundException;
    Object getInstanceOf(Object bean, Class<?> targetType);boolean isInstanceOf(Object bean, Class<?> targetType);
}
