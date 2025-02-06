# f5-dns-anycast

There are a total of four BIG-IPs in this lab setup.

The first BIG-IP (BIGIPD) serves as the Master/Primary DNS. This is where DNS records are updated or changed, and it performs Zone Transfers to the Slave/Secondary BIG-IPs.
BIGIPA, BIGIPB, and BIGIPC are in a DSC (Device Service Cluster) together, each with its own traffic group. This means all will appear as active, as each BIG-IP is assigned to an active traffic group (although the traffic group may not have floating objects in this environment). They function as Slave/Secondary DNS servers, handling DNS requests from clients.

On these Slave DNS servers, the DNS listener IP address is a virtual address (10.100.101.100), which is set to traffic-group 'none'. This allows it to be advertised from all BIG-IP devices.
The VyOS router picks up three different routes for 10.100.101.100 and distributes traffic across all three BIG-IPs using ECMP/BGP Multipath. In most environments, and by default in VyOS, multipath processing operates at Layer 3, meaning that all traffic from a single source/destination address pair is sent to the same BIG-IP. However, to introduce path diversity in the lab, VyOS was configured to perform multipath processing at Layer 4.

The traffic generator has a default route manually set to 10.1.40.8 (the VyOS router). It includes a script that can be executed to send DNS requests (dig) to 10.100.101.100, resolving www.testdomain.com.
