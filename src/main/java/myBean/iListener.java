package myBean;

import java.beans.PropertyChangeListener;

public interface iListener {
    void addPropertyChangeListener( PropertyChangeListener listener );
    void removePropertyChangeListener( PropertyChangeListener listener );
}
