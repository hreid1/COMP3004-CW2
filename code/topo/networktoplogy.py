from mininet.net import Mininet
from mininet.node import Controller, RemoteController, OVSController
from mininet.node import CPULimitedHost, Host, Node
from mininet.node import OVSKernelSwitch, UserSwitch
from mininet.node import IVSSwitch
from mininet.cli import CLI
from mininet.log import setLogLevel, info
from mininet.link import TCLink, Intf
from subprocess import call

def myNetwork():
    net = Mininet(topo=None, build=False, ipBase='10.0.0.0/8')

    c0 = net.addController(name='c0', controller=RemoteController, ip='192.168.0.24', port=6633)

    s1 = net.addSwitch('s1', cls=OVSKernelSwitch, protocols='OpenFlow13')
    s2 = net.addSwitch('s2', cls=OVSKernelSwitch, protocols='OpenFlow13')
    s3 = net.addSwitch('s3', cls=OVSKernelSwitch, protocols='OpenFlow13')

    h1 = net.addHost('h1', cls=Host, ip='10.0.0.1')
    h2 = net.addHost('h2', cls=Host, ip='10.0.0.2')
    h3 = net.addHost('h3', cls=Host, ip='10.0.0.3')
    h4 = net.addHost('h4', cls=Host, ip='10.0.0.4')

    net.addLink(h1, s1, cls=TCLink, bw=100, delay='1ms', loss=0)
    net.addLink(h2, s1, cls=TCLink, bw=100, delay='1ms', loss=0)

    # Bottleneck link    
    net.addLink(s1, s2, cls=TCLink, bw=1, delay='1ms', loss=0)

    net.addLink(s2, s3, cls=TCLink, bw=100, delay='1ms', loss=0)
    net.addLink(h3, s3, cls=TCLink, bw=100, delay='1ms', loss=0)
    net.addLink(h4, s3, cls=TCLink, bw=100, delay='1ms', loss=0)

    net.start()

    h1 = net.get('h1')
    h1.cmd('apache2ctl -k stop')
    h1.cmd('apache2ctl -k start')

    CLI(net)
    net.stop()

if __name__ == '__main__':
    setLogLevel('info')
    myNetwork()