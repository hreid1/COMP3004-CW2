sudo apt-get update
sudo apt upgrade

# Video compression stuff
sudo x264 --output bbb_1200k.264 --fps 30 --bitrate 1200 --video-filter resize:width=1280,height=720 bbb1.mp4
sudo MP4Box -add bbb_1200k.264 -fps 30 bbb_1200k.mp4
sudo MP4Box -dash 4000 -frag 4000 -segment-name segment_1200k_ bbb_1200k.mp4
