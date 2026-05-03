# Reduce video to 2 minutes
sudo cp bbb1.mp4 /var/www/html
cd /var/www/html

sudo ffmpeg -i bbb1.mp4 -t 00:02:00 bbb1_2m.mp4

sudo x264 --output bbb_2400k.264 --fps 30 --preset slow --bitrate 2400 --vbv-maxrate 4800 --vbv-bufsize 9600 --min-keyint 96 --keyint 96 --scenecut 0 --no-scenecut --pass 1 --video-filter resize:width=1280,height=720 bbb1.mp4
sudo MP4Box -add bbb_2400k.264 -fps 30 bbb_2400k.mp4 
sudo MP4Box -dash 4000 -frag 4000 -rap -segment-name segment_2400k_ bbb_2400k.mp4

sudo x264 --output bbb_1200k.264 --fps 30 --bitrate 1200 --video-filter resize:width=1280,height=720 bbb1.mp4
sudo MP4Box -add bbb_1200k.264 -fps 30 bbb_1200k.mp4
sudo MP4Box -dash 4000 -frag 4000 -rap -segment-name segment_1200k_ bbb_1200k.mp4

sudo x264 --output bbb_300k.264 --fps 30 --bitrate 300 --video-filter resize:width=1280,height=720 bbb1.mp4
sudo MP4Box -add bbb_300k.264 -fps 30 bbb_300k.mp4
sudo MP4Box -dash 4000 -frag 4000 -rap -segment-name segment_300k_ bbb_300k.mp4

sudo bash -c "cat << 'EOF' > /var/www/html/bbb_dash.mpd
<?xml version=\"1.0\"?>
<MPD xmlns=\"urn:mpeg:dash:schema:mpd:2011\" minBufferTime=\"PT1.500S\" type=\"static\" mediaPresentationDuration=\"PT0H2M0.000S\" profiles=\"urn:mpeg:dash:profile:full:2011\">
 <ProgramInformation>
  <Title>Combined SDN-IoT Adaptive Video</Title>
 </ProgramInformation>

 <Period duration=\"PT0H2M0.000S\">
  <AdaptationSet segmentAlignment=\"true\" maxWidth=\"1280\" maxHeight=\"720\" maxFrameRate=\"30\" par=\"16:9\" lang=\"und\" startWithSAP=\"1\">
   
   <!-- 2400k Representation -->
   <Representation id=\"2400\" mimeType=\"video/mp4\" codecs=\"avc1.64001F\" width=\"1280\" height=\"720\" frameRate=\"30\" bandwidth=\"2400000\">
    <SegmentTemplate media=\"segment_2400k_\$Number\$.m4s\" initialization=\"segment_2400k_init.mp4\" timescale=\"30\" startNumber=\"1\" duration=\"120\"/>
   </Representation>

   <!-- 1200k Representation -->
   <Representation id=\"1200\" mimeType=\"video/mp4\" codecs=\"avc1.64001F\" width=\"1280\" height=\"720\" frameRate=\"30\" bandwidth=\"1200000\">
    <SegmentTemplate media=\"segment_1200k_\$Number\$.m4s\" initialization=\"segment_1200k_init.mp4\" timescale=\"30\" startNumber=\"1\" duration=\"120\"/>
   </Representation>

   <!-- 300k Representation -->
   <Representation id=\"300\" mimeType=\"video/mp4\" codecs=\"avc1.64001F\" width=\"1280\" height=\"720\" frameRate=\"30\" bandwidth=\"300000\">
    <SegmentTemplate media=\"segment_300k_\$Number\$.m4s\" initialization=\"segment_300k_init.mp4\" timescale=\"30\" startNumber=\"1\" duration=\"120\"/>
   </Representation>

  </AdaptationSet>
 </Period>
</MPD>
EOF"