import javax.swing.*;
import java.beans.PropertyChangeListener;

/**
 * @author <a href="mailto:styrnov@wiley.com">tserj</a>
 * @version 24.06.11
 */
public class mainFrame extends JFrame {

    public JFormattedTextField macTf;
    public JFormattedTextField ipTf;
    public JFormattedTextField gatewayTf;

    public PropertyChangeListener listener = new listener(this);

    public String macValue;
    public String ipValue;
    public String gatewayValue;

    public mainFrame() {
        super();
        setSize(300, 200);
        build();
        setVisible(true);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

    private void build() {
        JPanel feedsPanel = new JPanel();
        feedsPanel.setLayout(new BoxLayout(feedsPanel, BoxLayout.X_AXIS));

        JLabel macLabel = new JLabel("Mac :");
        JLabel ipLabel = new JLabel("IP :");
        JLabel gatewayLabel = new JLabel("Gateway :");

        macTf = new JFormattedTextField();
        macTf.setColumns(10);
        macTf.addPropertyChangeListener("value", listener);

        ipTf = new JFormattedTextField();
        ipTf.setColumns(10);
        ipTf.addPropertyChangeListener("value", listener);

        gatewayTf = new JFormattedTextField();
        gatewayTf.setColumns(10);
        gatewayTf.addPropertyChangeListener("value", listener);

        JButton go = new JButton("Go");

        JPanel pan1 = new JPanel();
        pan1.add(macLabel);
        pan1.add(macTf);

        JPanel pan2 = new JPanel();
        pan2.add(ipLabel);
        pan2.add(ipTf);

        JPanel pan3 = new JPanel();
        pan3.add(gatewayLabel);
        pan3.add(gatewayTf);

        JPanel pan4 = new JPanel();
        pan4.add(go);

        feedsPanel.add(pan1);
        feedsPanel.add(pan2);
        feedsPanel.add(pan3);
        feedsPanel.add(pan4);
        add(feedsPanel);
        pack();
    }

}
