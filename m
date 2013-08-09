From: Joonas Saarinen <jonskunator@gmail.com>
Subject: Re: LG LW25 pin fix
Date: Fri, 09 Aug 2013 12:10:29 +0300
Message-ID: <5204B205.5040906@gmail.com>
References: <5203F5A7.5010004@gmail.com> <s5h7gfv9yji.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f41.google.com (mail-bk0-f41.google.com
 [209.85.214.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B3DD2656F5
 for <alsa-devel@alsa-project.org>; Fri,  9 Aug 2013 11:10:33 +0200 (CEST)
Received: by mail-bk0-f41.google.com with SMTP id na10so1014657bkb.28
 for <alsa-devel@alsa-project.org>; Fri, 09 Aug 2013 02:10:33 -0700 (PDT)
Received: from [172.20.0.36] (dsl-espbrasgw1-50dfb6-224.dhcp.inet.fi.
 [80.223.182.224])
 by mx.google.com with ESMTPSA id h5sm3254345bkg.8.2013.08.09.02.10.31
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 09 Aug 2013 02:10:32 -0700 (PDT)
In-Reply-To: <s5h7gfv9yji.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

upload=true&script=true&cardinfo=
!!################################
!!ALSA Information Script v 0.4.62
!!################################

!!Script ran on: Fri Aug  9 08:57:57 UTC 2013


!!Linux Distribution
!!------------------

Ubuntu 13.04 \n \l DISTRIB_ID=Ubuntu DISTRIB_DESCRIPTION="Ubuntu 13.04" 
NAME="Ubuntu" ID=ubuntu ID_LIKE=debian PRETTY_NAME="Ubuntu 13.04" 
HOME_URL="http://www.ubuntu.com/" SUPPORT_URL="http://help.ubuntu.com/" 
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"


!!DMI Information
!!---------------

Manufacturer:      LG Electronics
Product Name:      LW25-B7HV
Product Version:   Not Applicable
Firmware Version:  WRRESF03


!!Kernel Information
!!------------------

Kernel release:    3.8.0-27-generic
Operating System:  GNU/Linux
Architecture:      i686
Processor:         i686
SMP Enabled:       Yes


!!ALSA Version
!!------------

Driver version:     k3.8.0-27-generic
Library version:    1.0.25
Utilities version:  1.0.25


!!Loaded ALSA modules
!!-------------------

snd_hda_intel


!!Sound Servers on this system
!!----------------------------

Pulseaudio:
       Installed - Yes (/usr/bin/pulseaudio)
       Running - Yes


!!Soundcards recognised by ALSA
!!-----------------------------

  0 [Intel          ]: HDA-Intel - HDA Intel
                       HDA Intel at 0xd8540000 irq 44


!!PCI Soundcards installed in the system
!!--------------------------------------

00:1b.0 Audio device: Intel Corporation NM10/ICH7 Family High Definition 
Audio Controller (rev 02)
06:00.2 Mass storage controller: Texas Instruments 5-in-1 Multimedia 
Card Reader (SD/MMC/MS/MS PRO/xD)


!!Advanced information - PCI Vendor/Device/Subsystem ID's
!!-------------------------------------------------------

00:1b.0 0403: 8086:27d8 (rev 02)
     Subsystem: 1854:0077


!!Modprobe options (Sound related)
!!--------------------------------

snd_atiixp_modem: index=-2
snd_intel8x0m: index=-2
snd_via82xx_modem: index=-2
snd_usb_audio: index=-2
snd_usb_caiaq: index=-2
snd_usb_ua101: index=-2
snd_usb_us122l: index=-2
snd_usb_usx2y: index=-2
snd_cmipci: mpu_port=0x330 fm_port=0x388
snd_pcsp: index=-2
snd_usb_audio: index=-2
snd_hda_intel: 
patch=hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw


!!Loaded sound module options
!!---------------------------

!!Module: snd_hda_intel
     align_buffer_size : -1
     bdl_pos_adj : 
1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
     beep_mode : 
N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N,N
     enable : 
Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y,Y
     enable_msi : -1
     id : 
(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
     index : 
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
     jackpoll_ms : 
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
     model : 
(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
     patch : 
hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw,hda-jack-retask.fw,(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null),(null)
     position_fix : 
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
     power_save : 0
     power_save_controller : Y
     probe_mask : 
-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1
     probe_only : 
0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
     single_cmd : N
     snoop : Y


!!HDA-Intel Codec information
!!---------------------------
--startcollapse--

Codec: Realtek ALC880
Address: 0
AFG Function Id: 0x1 (unsol 0)
Vendor Id: 0x10ec0880
Subsystem Id: 0x00001854
Revision Id: 0x100800
No Modem Function Group found
Default PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
GPIO: io=2, o=0, i=0, unsolicited=1, wake=0
   IO[0]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
   IO[1]: enable=0, dir=0, wake=0, sticky=0, data=0, unsol=0
Node 0x02 [Audio Output] wcaps 0x411: Stereo
   Converter: stream=8, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3
   Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x411: Stereo
   Device: name="ALC880 Analog", type="Audio", device=0
   Converter: stream=8, channel=0
   PCM:
     rates [0x560]: 44100 48000 96000 192000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3
   Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x411: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3
   Power: setting=D0, actual=D0
Node 0x05 [Audio Output] wcaps 0x411: Stereo
   Converter: stream=0, channel=0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0xe]: 16 20 24
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3
   Power: setting=D0, actual=D0
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
   Control: name="IEC958 Playback Con Mask", index=0, device=0
   Control: name="IEC958 Playback Pro Mask", index=0, device=0
   Control: name="IEC958 Playback Default", index=0, device=0
   Control: name="IEC958 Playback Switch", index=0, device=0
   Control: name="IEC958 Default PCM Playback Switch", index=0, device=0
   Device: name="ALC880 Digital", type="SPDIF", device=1
   Converter: stream=8, channel=0
   Digital:
   Digital category: 0x0
   IEC Coding Type: 0x0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0x1e]: 16 20 24 32
     formats [0x1]: PCM
Node 0x07 [Audio Input] wcaps 0x10051b: Stereo Amp-In
   Control: name="Input Source", index=0, device=0
   Control: name="Capture Switch", index=0, device=0
   Control: name="Capture Volume", index=0, device=0
   Device: name="ALC880 Analog", type="Audio", device=0
   Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
   Amp-In vals:  [0x0b 0x0b]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0x6]: 16 20
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3
   Power: setting=D0, actual=D0
   Connection: 7
      0x18 0x19* 0x1a 0x1b 0x1c 0x14 0x15
Node 0x08 [Audio Input] wcaps 0x10051b: Stereo Amp-In
   Control: name="Input Source", index=1, device=0
   Control: name="Capture Switch", index=1, device=0
   Control: name="Capture Volume", index=1, device=0
   Device: name="ALC880 Analog", type="Audio", device=2
   Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
   Amp-In vals:  [0x80 0x80]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0x6]: 16 20
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3
   Power: setting=D0, actual=D0
   Connection: 7
      0x18 0x19* 0x1a 0x1b 0x1c 0x14 0x15
Node 0x09 [Audio Input] wcaps 0x10051b: Stereo Amp-In
   Control: name="Input Source", index=2, device=0
   Control: name="Capture Switch", index=2, device=0
   Control: name="Capture Volume", index=2, device=0
   Amp-In caps: ofs=0x00, nsteps=0x23, stepsize=0x03, mute=1
   Amp-In vals:  [0x80 0x80]
   Converter: stream=0, channel=0
   SDI-Select: 0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0x6]: 16 20
     formats [0x1]: PCM
   Power states:  D0 D1 D2 D3
   Power: setting=D0, actual=D0
   Connection: 10
      0x18 0x19* 0x1a 0x1b 0x1c 0x0b 0x14 0x15 0x16 0x17
Node 0x0a [Audio Input] wcaps 0x100391: Stereo Digital
   Converter: stream=0, channel=0
   SDI-Select: 0
   Digital:
   Digital category: 0x0
   IEC Coding Type: 0x0
   PCM:
     rates [0x160]: 44100 48000 96000
     bits [0x1e]: 16 20 24 32
     formats [0x1]: PCM
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x1f
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
   Control: name="Internal Mic Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=1, ofs=0
   Control: name="Internal Mic Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=1, ofs=0
   Control: name="Mic Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Mic Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=0, ofs=0
   Control: name="Line Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=2, ofs=0
   Control: name="Line Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=2, ofs=0
   Control: name="Beep Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=5, ofs=0
   Control: name="Beep Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=In, idx=5, ofs=0
   Amp-In caps: ofs=0x23, nsteps=0x41, stepsize=0x03, mute=1
   Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 
0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
   Connection: 8
      0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15
Node 0x0c [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Control: name="Speaker Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
   Amp-Out vals:  [0x3b 0x3b]
   Connection: 2
      0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Control: name="Headphone Playback Volume", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x00 0x00]
   Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
   Amp-Out vals:  [0x3b 0x3b]
   Connection: 2
      0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80]
   Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
   Amp-Out vals:  [0x40 0x40]
   Connection: 2
      0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
   Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-In vals:  [0x00 0x00] [0x80 0x80]
   Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
   Amp-Out vals:  [0x40 0x40]
   Connection: 2
      0x05 0x0b
Node 0x10 [Audio Selector] wcaps 0x300101: Stereo
   Connection: 4
      0x0c* 0x0d 0x0e 0x0f
Node 0x11 [Audio Selector] wcaps 0x300101: Stereo
   Connection: 4
      0x0c* 0x0d 0x0e 0x0f
Node 0x12 [Audio Selector] wcaps 0x300101: Stereo
   Connection: 4
      0x0c* 0x0d 0x0e 0x0f
Node 0x13 [Audio Selector] wcaps 0x300101: Stereo
   Connection: 4
      0x0c 0x0d* 0x0e 0x0f
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Control: name="Speaker Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="Speaker Phantom Jack", index=0, device=0
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
   Pin Default 0xb7031110: [Fixed] Line Out at Oth Mobile-In
     Conn = ATAPI, Color = Black
     DefAssociation = 0x1, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x40: OUT
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x0c
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x0d
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x0e
Node 0x17 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000003f: IN OUT HP Detect Trigger ImpSense
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x20: IN
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x0f
Node 0x18 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Control: name="Mic Jack", index=0, device=0
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
     Vref caps: HIZ 50 80
   Pin Default 0x01a19c22: [Jack] Mic at Ext Rear
     Conn = 1/8, Color = Pink
     DefAssociation = 0x2, Sequence = 0x2
   Pin-ctls: 0x21: IN VREF_50
   Unsolicited: tag=04, enabled=1
   Connection: 1
      0x10
Node 0x19 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Control: name="Internal Mic Phantom Jack", index=0, device=0
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
     Vref caps: HIZ 50 80
   Pin Default 0xb7a31120: [Fixed] Mic at Oth Mobile-In
     Conn = ATAPI, Color = Black
     DefAssociation = 0x2, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x24: IN VREF_80
   Unsolicited: tag=00, enabled=0
   Connection: 1
      0x11
Node 0x1a [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Control: name="Line Jack", index=0, device=0
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x80 0x80]
   Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
     Vref caps: HIZ 50 80
   Pin Default 0x01213c1f: [Jack] HP Out at Ext Rear
     Conn = 1/8, Color = Blue
     DefAssociation = 0x1, Sequence = 0xf
   Pin-ctls: 0x20: IN VREF_HIZ
   Unsolicited: tag=05, enabled=1
   Connection: 1
      0x12
Node 0x1b [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
   Control: name="Headphone Playback Switch", index=0, device=0
     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
   Control: name="Headphone Jack", index=0, device=0
   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
   Amp-Out vals:  [0x00 0x00]
   Pincap 0x0000133f: IN OUT HP Detect Trigger ImpSense
     Vref caps: HIZ 50 80
   Pin Default 0x01814c21: [Jack] Line In at Ext Rear
     Conn = 1/8, Color = Green
     DefAssociation = 0x2, Sequence = 0x1
   Pin-ctls: 0xc0: OUT HP VREF_HIZ
   Unsolicited: tag=01, enabled=1
   Connection: 1
      0x13
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
   Pincap 0x00000020: IN
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
   Pincap 0x00000020: IN
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
   Control: name="SPDIF Phantom Jack", index=0, device=0
   Pincap 0x00000010: OUT
   Pin Default 0x0145311e: [Jack] SPDIF Out at Ext Rear
     Conn = Optical, Color = Blue
     DefAssociation = 0x1, Sequence = 0xe
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
   Connection: 1
      0x06
Node 0x1f [Pin Complex] wcaps 0x400200: Mono Digital
   Pincap 0x00000020: IN
   Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
     Conn = 1/8, Color = Black
     DefAssociation = 0xf, Sequence = 0x0
     Misc = NO_PRESENCE
   Pin-ctls: 0x00:
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
   Processing caps: benign=0, ncoeff=10
Node 0x21 [Volume Knob Widget] wcaps 0x600080: Mono
   Volume-Knob: delta=0, steps=64, direct=0, val=26
   Unsolicited: tag=00, enabled=0
   Connection: 0
Codec: LSI Si3054
Address: 1
MFG Function Id: 0x2 (unsol 1)
Vendor Id: 0x11c13026
Subsystem Id: 0x11c13026
Revision Id: 0x100700
Modem Function Group: 0x1
--endcollapse--


!!ALSA Device nodes
!!-----------------

crw-rw---T+ 1 root audio 116, 10 Aug  9 00:03 /dev/snd/controlC0
crw-rw---T+ 1 root audio 116,  9 Aug  9 00:03 /dev/snd/hwC0D0
crw-rw---T+ 1 root audio 116,  8 Aug  9 00:03 /dev/snd/hwC0D1
crw-rw---T+ 1 root audio 116,  7 Aug  9 00:04 /dev/snd/pcmC0D0c
crw-rw---T+ 1 root audio 116,  6 Aug  9 11:55 /dev/snd/pcmC0D0p
crw-rw---T+ 1 root audio 116,  5 Aug  9 00:04 /dev/snd/pcmC0D1p
crw-rw---T+ 1 root audio 116,  4 Aug  9 00:03 /dev/snd/pcmC0D2c
crw-rw---T+ 1 root audio 116,  3 Aug  9 00:03 /dev/snd/pcmC0D6c
crw-rw---T+ 1 root audio 116,  2 Aug  9 00:03 /dev/snd/pcmC0D6p
crw-rw---T+ 1 root audio 116,  1 Aug  9 00:03 /dev/snd/seq
crw-rw---T+ 1 root audio 116, 33 Aug  9 00:03 /dev/snd/timer

/dev/snd/by-path:
total 0
drwxr-xr-x 2 root root  60 Aug  9 00:03 .
drwxr-xr-x 3 root root 280 Aug  9 00:03 ..
lrwxrwxrwx 1 root root  12 Aug  9 00:03 pci-0000:00:1b.0 -> ../controlC0


!!Aplay/Arecord output
!!--------------------

APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC880 Analog [ALC880 Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 1: ALC880 Digital [ALC880 Digital]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 6: Si3054 Modem [Si3054 Modem]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC880 Analog [ALC880 Analog]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: Intel [HDA Intel], device 2: ALC880 Analog [ALC880 Analog]
   Subdevices: 2/2
   Subdevice #0: subdevice #0
   Subdevice #1: subdevice #1
card 0: Intel [HDA Intel], device 6: Si3054 Modem [Si3054 Modem]
   Subdevices: 1/1
   Subdevice #0: subdevice #0

!!Amixer output
!!-------------

!!-------Mixer controls for card 0 [Intel]

Card hw:0 'Intel'/'HDA Intel at 0xd8540000 irq 44'
   Mixer name    : 'Realtek ALC880'
   Components    : 'HDA:10ec0880,00001854,00100800 
HDA:11c13026,11c13026,00100700'
   Controls      : 45
   Simple ctrls  : 19
Simple mixer control 'Master',0
   Capabilities: pvolume pvolume-joined pswitch pswitch-joined penum
   Playback channels: Mono
   Limits: Playback 0 - 64
   Mono: Playback 59 [92%] [-5.00dB] [on]
Simple mixer control 'Headphone',0
   Capabilities: pvolume pswitch penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 64
   Mono:
   Front Left: Playback 64 [100%] [0.00dB] [on]
   Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'Speaker',0
   Capabilities: pvolume pswitch penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 64
   Mono:
   Front Left: Playback 64 [100%] [0.00dB] [on]
   Front Right: Playback 64 [100%] [0.00dB] [on]
Simple mixer control 'PCM',0
   Capabilities: pvolume penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 255
   Mono:
   Front Left: Playback 254 [100%] [0.20dB]
   Front Right: Playback 254 [100%] [0.20dB]
Simple mixer control 'Line',0
   Capabilities: pvolume pswitch penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 65
   Mono:
   Front Left: Playback 0 [0%] [-35.00dB] [off]
   Front Right: Playback 0 [0%] [-35.00dB] [off]
Simple mixer control 'Mic',0
   Capabilities: pvolume pswitch penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 65
   Mono:
   Front Left: Playback 0 [0%] [-35.00dB] [off]
   Front Right: Playback 0 [0%] [-35.00dB] [off]
Simple mixer control 'IEC958',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'IEC958 Default PCM',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [on]
Simple mixer control 'Beep',0
   Capabilities: pvolume pswitch penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 65
   Mono:
   Front Left: Playback 0 [0%] [-35.00dB] [off]
   Front Right: Playback 0 [0%] [-35.00dB] [off]
Simple mixer control 'Capture',0
   Capabilities: cvolume cswitch penum
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 35
   Front Left: Capture 11 [31%] [11.00dB] [on]
   Front Right: Capture 11 [31%] [11.00dB] [on]
Simple mixer control 'Capture',1
   Capabilities: cvolume cswitch penum
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 35
   Front Left: Capture 0 [0%] [0.00dB] [off]
   Front Right: Capture 0 [0%] [0.00dB] [off]
Simple mixer control 'Capture',2
   Capabilities: cvolume cswitch penum
   Capture channels: Front Left - Front Right
   Limits: Capture 0 - 35
   Front Left: Capture 0 [0%] [0.00dB] [off]
   Front Right: Capture 0 [0%] [0.00dB] [off]
Simple mixer control 'Auto-Mute Mode',0
   Capabilities: enum
   Items: 'Disabled' 'Enabled'
   Item0: 'Enabled'
Simple mixer control 'Caller ID',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [off]
Simple mixer control 'Input Source',0
   Capabilities: cenum
   Items: 'Internal Mic' 'Mic' 'Line'
   Item0: 'Internal Mic'
Simple mixer control 'Input Source',1
   Capabilities: cenum
   Items: 'Internal Mic' 'Mic' 'Line'
   Item0: 'Internal Mic'
Simple mixer control 'Input Source',2
   Capabilities: cenum
   Items: 'Internal Mic' 'Mic' 'Line'
   Item0: 'Internal Mic'
Simple mixer control 'Internal Mic',0
   Capabilities: pvolume pswitch penum
   Playback channels: Front Left - Front Right
   Limits: Playback 0 - 65
   Mono:
   Front Left: Playback 0 [0%] [-35.00dB] [off]
   Front Right: Playback 0 [0%] [-35.00dB] [off]
Simple mixer control 'Off-hook',0
   Capabilities: pswitch pswitch-joined penum
   Playback channels: Mono
   Mono: Playback [off]


!!Alsactl output
!!--------------

--startcollapse--
state.Intel {
     control.1 {
         iface MIXER
         name 'Headphone Playback Volume'
         value.0 64
         value.1 64
         comment {
             access 'read write'
             type INTEGER
             count 2
             range '0 - 64'
             dbmin -6400
             dbmax 0
             dbvalue.0 0
             dbvalue.1 0
         }
     }
     control.2 {
         iface MIXER
         name 'Headphone Playback Switch'
         value.0 true
         value.1 true
         comment {
             access 'read write'
             type BOOLEAN
             count 2
         }
     }
     control.3 {
         iface MIXER
         name 'Speaker Playback Volume'
         value.0 64
         value.1 64
         comment {
             access 'read write'
             type INTEGER
             count 2
             range '0 - 64'
             dbmin -6400
             dbmax 0
             dbvalue.0 0
             dbvalue.1 0
         }
     }
     control.4 {
         iface MIXER
         name 'Speaker Playback Switch'
         value.0 true
         value.1 true
         comment {
             access 'read write'
             type BOOLEAN
             count 2
         }
     }
     control.5 {
         iface MIXER
         name 'Internal Mic Playback Volume'
         value.0 0
         value.1 0
         comment {
             access 'read write'
             type INTEGER
             count 2
             range '0 - 65'
             dbmin -3500
             dbmax 3000
             dbvalue.0 -3500
             dbvalue.1 -3500
         }
     }
     control.6 {
         iface MIXER
         name 'Internal Mic Playback Switch'
         value.0 false
         value.1 false
         comment {
             access 'read write'
             type BOOLEAN
             count 2
         }
     }
     control.7 {
         iface MIXER
         name 'Mic Playback Volume'
         value.0 0
         value.1 0
         comment {
             access 'read write'
             type INTEGER
             count 2
             range '0 - 65'
             dbmin -3500
             dbmax 3000
             dbvalue.0 -3500
             dbvalue.1 -3500
         }
     }
     control.8 {
         iface MIXER
         name 'Mic Playback Switch'
         value.0 false
         value.1 false
         comment {
             access 'read write'
             type BOOLEAN
             count 2
         }
     }
     control.9 {
         iface MIXER
         name 'Line Playback Volume'
         value.0 0
         value.1 0
         comment {
             access 'read write'
             type INTEGER
             count 2
             range '0 - 65'
             dbmin -3500
             dbmax 3000
             dbvalue.0 -3500
             dbvalue.1 -3500
         }
     }
     control.10 {
         iface MIXER
         name 'Line Playback Switch'
         value.0 false
         value.1 false
         comment {
             access 'read write'
             type BOOLEAN
             count 2
         }
     }
     control.11 {
         iface MIXER
         name 'Auto-Mute Mode'
         value Enabled
         comment {
             access 'read write'
             type ENUMERATED
             count 1
             item.0 Disabled
             item.1 Enabled
         }
     }
     control.12 {
         iface MIXER
         name 'Capture Switch'
         value.0 true
         value.1 true
         comment {
             access 'read write'
             type BOOLEAN
             count 2
         }
     }
     control.13 {
         iface MIXER
         name 'Capture Switch'
         index 1
         value.0 false
         value.1 false
         comment {
             access 'read write'
             type BOOLEAN
             count 2
         }
     }
     control.14 {
         iface MIXER
         name 'Capture Switch'
         index 2
         value.0 false
         value.1 false
         comment {
             access 'read write'
             type BOOLEAN
             count 2
         }
     }
     control.15 {
         iface MIXER
         name 'Capture Volume'
         value.0 11
         value.1 11
         comment {
             access 'read write'
             type INTEGER
             count 2
             range '0 - 35'
             dbmin 0
             dbmax 3500
             dbvalue.0 1100
             dbvalue.1 1100
         }
     }
     control.16 {
         iface MIXER
         name 'Capture Volume'
         index 1
         value.0 0
         value.1 0
         comment {
             access 'read write'
             type INTEGER
             count 2
             range '0 - 35'
             dbmin 0
             dbmax 3500
             dbvalue.0 0
             dbvalue.1 0
         }
     }
     control.17 {
         iface MIXER
         name 'Capture Volume'
         index 2
         value.0 0
         value.1 0
         comment {
             access 'read write'
             type INTEGER
             count 2
             range '0 - 35'
             dbmin 0
             dbmax 3500
             dbvalue.0 0
             dbvalue.1 0
         }
     }
     control.18 {
         iface MIXER
         name 'Input Source'
         value 'Internal Mic'
         comment {
             access 'read write'
             type ENUMERATED
             count 1
             item.0 'Internal Mic'
             item.1 Mic
             item.2 Line
         }
     }
     control.19 {
         iface MIXER
         name 'Input Source'
         index 1
         value 'Internal Mic'
         comment {
             access 'read write'
             type ENUMERATED
             count 1
             item.0 'Internal Mic'
             item.1 Mic
             item.2 Line
         }
     }
     control.20 {
         iface MIXER
         name 'Input Source'
         index 2
         value 'Internal Mic'
         comment {
             access 'read write'
             type ENUMERATED
             count 1
             item.0 'Internal Mic'
             item.1 Mic
             item.2 Line
         }
     }
     control.21 {
         iface MIXER
         name 'IEC958 Playback Con Mask'
         value 
'0fff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
         comment {
             access read
             type IEC958
             count 1
         }
     }
     control.22 {
         iface MIXER
         name 'IEC958 Playback Pro Mask'
         value 
'0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
         comment {
             access read
             type IEC958
             count 1
         }
     }
     control.23 {
         iface MIXER
         name 'IEC958 Playback Default'
         value 
'0400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
         comment {
             access 'read write'
             type IEC958
             count 1
         }
     }
     control.24 {
         iface MIXER
         name 'IEC958 Playback Switch'
         value false
         comment {
             access 'read write'
             type BOOLEAN
             count 1
         }
     }
     control.25 {
         iface MIXER
         name 'IEC958 Default PCM Playback Switch'
         value true
         comment {
             access 'read write'
             type BOOLEAN
             count 1
         }
     }
     control.26 {
         iface MIXER
         name 'Beep Playback Volume'
         value.0 0
         value.1 0
         comment {
             access 'read write'
             type INTEGER
             count 2
             range '0 - 65'
             dbmin -3500
             dbmax 3000
             dbvalue.0 -3500
             dbvalue.1 -3500
         }
     }
     control.27 {
         iface MIXER
         name 'Beep Playback Switch'
         value.0 false
         value.1 false
         comment {
             access 'read write'
             type BOOLEAN
             count 2
         }
     }
     control.28 {
         iface MIXER
         name 'Master Playback Volume'
         value 59
         comment {
             access 'read write'
             type INTEGER
             count 1
             range '0 - 64'
             dbmin -6400
             dbmax 0
             dbvalue.0 -500
         }
     }
     control.29 {
         iface MIXER
         name 'Master Playback Switch'
         value true
         comment {
             access 'read write'
             type BOOLEAN
             count 1
         }
     }
     control.30 {
         iface CARD
         name 'Headphone Jack'
         value false
         comment {
             access read
             type BOOLEAN
             count 1
         }
     }
     control.31 {
         iface CARD
         name 'Speaker Phantom Jack'
         value true
         comment {
             access read
             type BOOLEAN
             count 1
         }
     }
     control.32 {
         iface CARD
         name 'Internal Mic Phantom Jack'
         value true
         comment {
             access read
             type BOOLEAN
             count 1
         }
     }
     control.33 {
         iface CARD
         name 'Mic Jack'
         value false
         comment {
             access read
             type BOOLEAN
             count 1
         }
     }
     control.34 {
         iface CARD
         name 'Line Jack'
         value false
         comment {
             access read
             type BOOLEAN
             count 1
         }
     }
     control.35 {
         iface CARD
         name 'SPDIF Phantom Jack'
         value true
         comment {
             access read
             type BOOLEAN
             count 1
         }
     }
     control.36 {
         iface PCM
         name 'Playback Channel Map'
         value.0 0
         value.1 0
         comment {
             access read
             type INTEGER
             count 2
             range '0 - 36'
         }
     }
     control.37 {
         iface PCM
         name 'Capture Channel Map'
         value.0 0
         value.1 0
         comment {
             access read
             type INTEGER
             count 2
             range '0 - 36'
         }
     }
     control.38 {
         iface PCM
         device 1
         name 'Playback Channel Map'
         value.0 0
         value.1 0
         comment {
             access read
             type INTEGER
             count 2
             range '0 - 36'
         }
     }
     control.39 {
         iface PCM
         device 2
         name 'Capture Channel Map'
         value.0 0
         value.1 0
         comment {
             access read
             type INTEGER
             count 2
             range '0 - 36'
         }
     }
     control.40 {
         iface PCM
         device 2
         name 'Capture Channel Map'
         index 1
         value.0 0
         value.1 0
         comment {
             access read
             type INTEGER
             count 2
             range '0 - 36'
         }
     }
     control.41 {
         iface MIXER
         name 'Off-hook Switch'
         value false
         comment {
             access 'read write'
             type BOOLEAN
             count 1
         }
     }
     control.42 {
         iface MIXER
         name 'Caller ID Switch'
         value false
         comment {
             access 'read write'
             type BOOLEAN
             count 1
         }
     }
     control.43 {
         iface PCM
         device 6
         name 'Playback Channel Map'
         value 0
         comment {
             access read
             type INTEGER
             count 1
             range '0 - 36'
         }
     }
     control.44 {
         iface PCM
         device 6
         name 'Capture Channel Map'
         value 0
         comment {
             access read
             type INTEGER
             count 1
             range '0 - 36'
         }
     }
     control.45 {
         iface MIXER
         name 'PCM Playback Volume'
         value.0 254
         value.1 254
         comment {
             access 'read write user'
             type INTEGER
             count 2
             range '0 - 255'
             tlv '0000000100000008ffffec1400000014'
             dbmin -5100
             dbmax 0
             dbvalue.0 -20
             dbvalue.1 -20
         }
     }
}
--endcollapse--


!!All Loaded Modules
!!------------------

Module
nls_iso8859_1
parport_pc
ppdev
rfcomm
bnep
snd_hda_codec_si3054
snd_hda_codec_realtek
mmc_block
joydev
snd_hda_intel
pcmcia
snd_hda_codec
snd_hwdep
snd_pcm
snd_page_alloc
snd_seq_midi
snd_seq_midi_event
coretemp
snd_rawmidi
kvm_intel
kvm
tifm_sd
arc4
snd_seq
snd_seq_device
iwl3945
iwlegacy
yenta_socket
pcmcia_rsrc
pcmcia_core
btusb
snd_timer
wmi
mac80211
tifm_7xx1
tifm_core
mac_hid
i915
bluetooth
snd
video
drm_kms_helper
drm
lpc_ich
i2c_algo_bit
et131x
cfg80211
microcode
psmouse
lp
soundcore
parport
serio_raw
sdhci_pci
firewire_ohci
firewire_core
sdhci
crc_itu_t


!!Sysfs Files
!!-----------

/sys/class/sound/hwC0D0/init_pin_configs:
0x14 0xb7031110
0x15 0x411111f0
0x16 0x411111f0
0x17 0x411111f0
0x18 0x01a19c22
0x19 0xb7a31120
0x1a 0x01213c1f
0x1b 0x01814c21
0x1c 0x411111f0
0x1d 0x411111f0
0x1e 0x0145311e
0x1f 0x411111f0

/sys/class/sound/hwC0D0/driver_pin_configs:

/sys/class/sound/hwC0D0/user_pin_configs:
0x14 0xb7031110
0x15 0x411111f0
0x16 0x411111f0
0x17 0x411111f0
0x18 0x01a19c22
0x19 0xb7a31120
0x1a 0x0181344f
0x1b 0x0321403f
0x1c 0x411111f0
0x1d 0x411111f0
0x1e 0x0145311e
0x1f 0x411111f0

/sys/class/sound/hwC0D0/init_verbs:

/sys/class/sound/hwC0D0/hints:

/sys/class/sound/hwC0D1/init_pin_configs:

/sys/class/sound/hwC0D1/driver_pin_configs:

/sys/class/sound/hwC0D1/user_pin_configs:

/sys/class/sound/hwC0D1/init_verbs:

/sys/class/sound/hwC0D1/hints:


!!ALSA/HDA dmesg
!!--------------

[   21.341396] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on 
minor 0
[   21.341624] snd_hda_intel 0000:00:1b.0: irq 44 for MSI/MSI-X
[   21.347831] hda-intel 0000:00:1b.0: Applying patch firmware 
'hda-jack-retask.fw'
[   21.404365] input: HDA Intel Line as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input7
[   21.404508] input: HDA Intel Mic as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input8
[   21.405210] input: HDA Intel Headphone as 
/devices/pci0000:00/0000:00:1b.0/sound/card0/input9
[   21.410861] mmcblk0: error -110 transferring data, sector 11896, nr 
24, cmd response 0x900, card status 0xb00
--
[ 1598.382616] i915 0000:00:02.0: setting latency timer to 64
[ 1598.382948] snd_hda_intel 0000:00:1b.0: irq 44 for MSI/MSI-X
[ 1598.385216] uhci_hcd 0000:00:1d.0: setting latency timer to 64



On 09.08.2013 09:19, Takashi Iwai wrote:
> At Thu, 08 Aug 2013 22:46:47 +0300,
> Joonas Saarinen wrote:
>> Hello, I discovered that the LG LW25 laptop needs a small fix to its pin
>> mapping. The functions of blue and green jacks simply have to be
>> interchanged. The rest of the configuration is correct. Can this fix be
>> made permanent in the driver?
> Yes, but I need to know PCI SSID and/or codec SSID.
> Could you give alsa-info.sh output on the machine?
>
>
> thanks,
>
> Takashi
>
>> The fixed mappings are:
>>
>> 0x1a 0x0181344f
>> 0x1b 0x0321403f
>>
>> Here's the full correct map:
>>
>> [codec]
>> 0x10ec0880 0x00001854 0
>>
>> [pincfg]
>> 0x14 0xb7031110
>> 0x15 0x411111f0
>> 0x16 0x411111f0
>> 0x17 0x411111f0
>> 0x18 0x01a19c22
>> 0x19 0xb7a31120
>> 0x1a 0x0181344f
>> 0x1b 0x0321403f
>> 0x1c 0x411111f0
>> 0x1d 0x411111f0
>> 0x1e 0x0145311e
>> 0x1f 0x411111f0
>>
>>
>> Thanks,
>> Joonas
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
