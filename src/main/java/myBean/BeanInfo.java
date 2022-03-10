package myBean;

import java.awt.*;
import java.beans.BeanDescriptor;
import java.beans.EventSetDescriptor;
import java.beans.MethodDescriptor;
import java.beans.PropertyDescriptor;

public interface BeanInfo {
    MethodDescriptor[] getMethodDescriptors();
    BeanDescriptor getBeanDescriptor();
    EventSetDescriptor[] getEventSetDescriptors();
    int getDefaultEventIndex();
    PropertyDescriptor[] getPropertyDescriptors();
    Image getIcon(int iconKind);
    int getDefaultPropertyIndex();

}
