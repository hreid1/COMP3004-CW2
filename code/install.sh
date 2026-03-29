sudo apt-get update
sudo apt upgrade

sudo apt-get install mininet

cat > networktopology.py << 'EOF'
from mininet.net import Mininet
from mininet.node import RemoteController, OVSSwitch
from mininet.cli import CLI
from mininet.log import setLogLevel

def start_network():
    net = Mininet(controller=RemoteController, switch=OVSSwitch)
    c0 = net.addController('c0', ip='192.168.0.97', port=6633)

    h1 = net.addHost('h1', ip='10.0.0.1')
    h2 = net.addHost('h2', ip='10.0.0.2')
    s1 = net.addSwitch('s1', protocols='OpenFlow13')

    net.addLink(h1, s1)
    net.addLink(h2, s1)

    net.start()

    CLI(net)

    net.stop()

if __name__ == "__main__":
    setLogLevel('info')
    start_network()
EOF

sudo python3 networktopology.py
