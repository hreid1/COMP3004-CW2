from mininet.topo import Topo
from mininet.net import Mininet
from mininet.util import dumpNodeConnections
from mininet.log import setLogLevel

class network(Topo):
    def build(self):
        s1 = self.addSwitch('s1')
