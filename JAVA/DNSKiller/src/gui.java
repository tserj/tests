/**
 * @author <a href="mailto:styrnov@wiley.com">tserj</a>
 * @version 24.06.11
 */
public class gui {
    private static final String MAC = "48-5B-39-F3-CE-FE";
    private static final String IP = "192.168.110.105";
    private static final String GATEWAY = "192.168.110.100";
    private static final String INTERFACE = "Atheros AR8121/AR8113/AR8114 PCI-E Ethernet Controller (Microsoft's Packet Scheduler)";

    public static void main (String[] args) throws Exception {
        mainFrame data = new mainFrame();
        new sender(INTERFACE, MAC, IP, GATEWAY);
    }
}
