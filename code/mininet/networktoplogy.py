from mininet.net import Mininet
from mininet.node import Controller
from mininet.cli import CLI
from mininet.link import TCLink
from mininet.log import setLogLevel, info
from mininet.node import OVSKernelSwitch, RemoteController

def myNetwork():
    net = Mininet(topo=None, build=False)
    c0 = net.addController(name='c0', controller=RemoteController, ip='', port=6633)

    s1 = net.addSwitch('s1')
    s2 = net.addSwitch('s2')
    s3 = net.addSwitch('s3')

    h1 = net.addHost('h1')
    h2 = net.addHost('h2')
    h3 = net.addHost('h3')

    net.addLink(h1, s1, cls=TCLink, bw=100, delay='1ms', loss=0)
    net.addLink(h2, s1, cls=TCLink, bw=100, delay='1ms', loss=2)
    net.addLink(h3, s1, cls=TCLink, bw=100, delay='1ms', loss=2)

    net.start()
    CLI(net)
    net.stop()

if __name__ == "__main__":
    setLogLevel('info')
    myNetwork()