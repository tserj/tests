import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;

/**
 * @author <a href="mailto:styrnov@wiley.com">tserj</a>
 * @version 24.06.11
 */
public class listener implements PropertyChangeListener {

    private mainFrame parent;

    public listener(mainFrame parent) {
        this.parent = parent;
    }

    public void propertyChange(PropertyChangeEvent e) {
        Object source = e.getSource();

        if (source == parent.macTf) {
            parent.macValue = parent.macTf.getValue().toString();
        } else if (source == parent.ipTf) {
            parent.ipValue = parent.ipTf.getValue().toString();
        } else if (source == parent.gatewayTf) {
            parent.gatewayValue = parent.gatewayTf.getValue().toString();
        }

        //double payment = computePayment(amount, rate, numPeriods);
        //paymentField.setValue(new Double(payment));
    }

}
