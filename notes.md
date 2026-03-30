# Project Report

## CW overview

- Build up an SDN testbed in a VM (e.g. Ubuntu) to support HTTP video streaming and IoT traffic
  - Include the installation of the mininet (network emulator), Apache server, Dash.js player and support packages/dependencies
- Automate the install (shell scripts) for the required software packages to be installed on a VM in order to build up the testbed
- Install an SDN controller (e.g. Ryu or OpenDaylight) in another VM
- Write python code to build up a network topology in mininet and connect it to an external SDN controller 
  - Should include three virtual switches in a line where two links are used to connect three virtual switches
  - You need to setup one link as the bottleneck link for video streaming and IoT traffic
  - You can make assumptions for other networking connections/settings in the network topology
- Prepare segmented video representations (including 3 different video representations) in H.264/AVC based on a sample test video and create a combined MPD file to support adaptive video streaming
- Setup mixed traffic flows:
  - One host generates adaptive video streaming traffic
  - Several hosts generate IoT-like traffic
- Carry out experiments on video streaming over SDN networks under different network conditions (e.g. low/medium/high bottleneck link) use:
  - `iperf` to test the network bandwidth and application-level quality variations based on statistics provided by `DASH.js`, e.g. bitrate downloading and dropped frames, and demonstrate that adaptive video streaming is working
- Apply SDN control policies to prioritise to IoT traffic versus best-effort video traffic
  - Compare results with and without SDN control
- Provide evidence and comment on how the external SDN controller can collect/report on network statistics based on REST API and what these information can be used for in terms of network monitoring and management 

## Checklist
- SDN testbed
  - Install mininet, Apache server, Dash.js and supporting packages/dependencies
- Automate install via shell scripts
- Install an SDN OpenDaylight controller **in another VM**
- Write python code to build a network topology in mininet and connect to SDN controller
    - 3 virtual switches 
    - 2 links are used to connect 3 virtual switches
    - Setup one link for video streaming and IoT traffic
- Show 3 different video representations in H.264/AVC and create a combined MPD file
- Setup mixed traffic flows:
  - One host generates adaptive video streaming
  - Several hosts generate IoT like traffic
- Carry out experiments under different network conditions (e.g. low, medium and high)
    - Use `iperf`
- Apply SDN policies to prioritise **IoT traffic over best-effort video traffic**
- Provid evidence on how the external SDN controller can collect info based on REST API

## Process

- Dependencies
  - `sudo apt update`
  - `sudo apt upgrade -y`
  - Mininet
    - `sudo apt install -y mininet openvswitch-switch`
    - `sudo apt install -y iperf net-tools curl`
    - `sudo apt install -y python3-pip
    - `pip3 install mininet`
  - Apache
    - `sudo apt-get install apache2`
  - X264 and MP4Box
    - `sudo apt-get install x264`
    - `sudo apt-get install gpac`
  - `sudo apt install ansible`
- Load Mininet
- Load ODL VMs
- Use mininet python API
- On ODL VM - `cd odl/bin` - `./karaf`
- Host dash.js on Apache server

## Structure

- Abstract
- Introduction
- Experiment/Testbed setup
- Experiments, Results and Analysis
- Conclusions
- References
- Video