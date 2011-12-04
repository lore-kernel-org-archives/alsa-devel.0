From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: Clevo P170HM / Sager NP8170 audio
Date: Sun, 04 Dec 2011 13:41:02 +0100
Message-ID: <jbfpov$f4u$1@dough.gmane.org>
References: <CAOUOUDyXhM8WiKOBouRV6_Es6_9rvHLGrjvywQT5foE=uW7eUw@mail.gmail.com>
	<ja2hkv$1lt$1@dough.gmane.org> <ja2i5r$5br$1@dough.gmane.org>
	<CAN8cciZRGvYU8FcnEA1JfBUwe277ce3c3xSC_ftt+oa1vhzWdw@mail.gmail.com>
	<ja7rs9$fth$1@dough.gmane.org>
	<CAN8ccib2wjGOp+2mwU=q48bmv+1w48vaPU=RyXU_fnY8JUSQ-Q@mail.gmail.com>
	<jadd9f$9e1$1@dough.gmane.org>
	<CAN8cciYju3PPZRHf8--oubYc7vVe7-X0D36iGEX=W=uxRpM9sg@mail.gmail.com>
	<jag5h0$ioh$1@dough.gmane.org>
	<CAN8ccianih_LZZW6n+Ksa0gCo2i3gcbdnV_f8QMJNMjz7p=pbA@mail.gmail.com>
	<4ECF85A0.20504@gmail.com>
	<CAN8cciYn_CSgrXHThe=TRBmC98e_XhkT=W8f=UaPp5Tg-c7vSw@mail.gmail.com>
	<javv4p$olp$1@dough.gmane.org>
	<CAN8ccibQX-Lqdn0T-WWtkqjM427TenpLX4OuzuwSCOz7j4RcWQ@mail.gmail.com>
	<jb2bui$bre$1@dough.gmane.org> <jb8abo$vtb$1@dough.gmane.org>
	<CAN8cciaa327+_XA-BarL9-st=J4Zic=iYp3pDCKm_gtCohWd9w@mail.gmail.com>
	<jbark0$7e6$1@dough.gmane.org>
	<CAN8cciZGmMZO+mm=CKSLOSV4s36hgE2czy_ppxBcj_dJ138U+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040505080604060904040906"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 03567246FA
	for <alsa-devel@alsa-project.org>; Sun,  4 Dec 2011 13:41:19 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1RXBNe-0000nS-De
	for alsa-devel@alsa-project.org; Sun, 04 Dec 2011 13:41:18 +0100
Received: from 217-162-57-177.dynamic.hispeed.ch ([217.162.57.177])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 04 Dec 2011 13:41:18 +0100
Received: from belegdol by 217-162-57-177.dynamic.hispeed.ch with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 04 Dec 2011 13:41:18 +0100
In-Reply-To: <CAN8cciZGmMZO+mm=CKSLOSV4s36hgE2czy_ppxBcj_dJ138U+g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040505080604060904040906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

W dniu 04.12.2011 00:59, Raymond Yau pisze:
> 2011/12/2 Julian Sikorski <belegdol@gmail.com>:
>> W dniu 02.12.2011 01:52, Raymond Yau pisze:
>>>>>>>
>>>>>>> $ aplay -l
>>>>>>> **** List of PLAYBACK Hardware Devices ****
>>>>>>> card 0: PCH [HDA Intel PCH], device 0: ALC892 Analog [ALC892 Analog]
>>>>>>>  Subdevices: 1/1
>>>>>>>  Subdevice #0: subdevice #0
>>>>>>> card 0: PCH [HDA Intel PCH], device 1: ALC892 Digital [ALC892 Digital]
>>>>>>>  Subdevices: 1/1
>>>>>>>  Subdevice #0: subdevice #0
>>>>>>> card 1: NVidia [HDA NVidia], device 3: HDMI 0 [HDMI 0]
>>>>>>>  Subdevices: 1/1
>>>>>>>  Subdevice #0: subdevice #0
>>>>>>> card 1: NVidia [HDA NVidia], device 7: HDMI 0 [HDMI 0]
>>>>>>>  Subdevices: 1/1
>>>>>>>  Subdevice #0: subdevice #0
>>>>>>> card 1: NVidia [HDA NVidia], device 8: HDMI 0 [HDMI 0]
>>>>>>>  Subdevices: 1/1
>>>>>>>  Subdevice #0: subdevice #0
>>>>>>> card 1: NVidia [HDA NVidia], device 9: HDMI 0 [HDMI 0]
>>>>>>>  Subdevices: 1/1
>>>>>>>  Subdevice #0: subdevice #0
>>>>>>>
>>>
>>> How many hdmi connectors on your nvidia ?
>>>
>>> From the viewpoint of the user, I expect only one PCM device for each
>>> hdmi connector
>>
>> There is one hdmi and one dvi. I did not try sending sound via hdmi, though.
>>
> 
> http://thread.gmane.org/gmane.linux.alsa.devel/92097

It seems like this patch requires hda-jack branch. Is there anything
particular I should keep in mind?

> 
>>>
>>>
>>> if you compled alsa-driver in debug mode, you should see the following
>>> message in system log.
>>>
>> How would I do that? Which config option do I need to change?
>>
>>> realtek: Enable HP auto-muting on NID 0x1b
>>> realtek: Enable Line-Out auto-muting on NID 0x17
>>>
> 
> configure --with-debug=verbose
> 
> In theory, , the driver can automatically mute IEC958 Playback Switch
> (turn off the red light for power saving) when you plug/unplug the
> side jack which share with spdif

There is no alsa-driver package in Fedora. As such, I have checked
configure.ac to see what config options are getting changed. It turns
out that CONFIG_SND_DEBUG, CONFIG_SND_DEBUG_VERBOSE and
CONFIG_SND_DEBUG_MEM are changed to y. Since I could not find
CONFIG_SND_DEBUG_MEM anywhere in 3.2 kernel, I only changed the other two:

[   10.631612] ALSA sound/pci/hda/patch_realtek.c:1504 hda_codec:
ALC892: Apply pincfg for Clevo P150HM
[   10.631631] ALSA sound/pci/hda/hda_codec.c:4957 autoconfig:
line_outs=1 (0x17/0x0/0x0/0x0/0x0) type:line
[   10.631638] ALSA sound/pci/hda/hda_codec.c:4961    speaker_outs=1
(0x14/0x0/0x0/0x0/0x0)
[   10.631644] ALSA sound/pci/hda/hda_codec.c:4965    hp_outs=1
(0x1b/0x0/0x0/0x0/0x0)
[   10.631648] ALSA sound/pci/hda/hda_codec.c:4966    mono: mono_out=0x0
[   10.631652] ALSA sound/pci/hda/hda_codec.c:4969    dig-out=0x1e/0x0
[   10.631656] ALSA sound/pci/hda/hda_codec.c:4970    inputs:
[   10.631662] ALSA sound/pci/hda/hda_codec.c:4974  Mic=0x18
[   10.631667] ALSA sound/pci/hda/hda_codec.c:4974  Internal Mic=0x19
[   10.631671] ALSA sound/pci/hda/hda_codec.c:4974  Line=0x1a
[   10.631675] ALSA sound/pci/hda/hda_codec.c:4976
[   10.632857] Front playback volume 2 pin 14
[   10.632859] Front playback switch 14
[   10.632942] Surround playback volume 3 pin 1a
[   10.632944] Surround playback switch 1a
[   10.633111] Side playback volume 5 pin 17
[   10.633112] Side playback switch 17
[   10.633983] ALSA sound/pci/hda/patch_realtek.c:1342 realtek: No valid
SSID, checking pincfg 0x598301f0 for NID 0x1d
[   10.633985] ALSA sound/pci/hda/patch_realtek.c:1425 realtek: Enable
default setup for auto mode as fallback
[   10.634027] ALSA sound/pci/hda/patch_realtek.c:971 realtek: Enable HP
auto-muting on NID 0x1b
[   10.634081] ALSA sound/pci/hda/patch_realtek.c:985 realtek: Enable
Line-Out auto-muting on NID 0x17

Still, it is either all or nothing setting despite what alsamixer says.

> 
>>> The drawback is "Front Playback Volume" and "Front Playback Switch"
>>> does not control the "Headphone Jack" which used as "Front" jack
>>
>> Not really a drawback, since in an unpatched 3.1.2 kernel there are
>> separate "Speaker" and "Headphone" controls which are independent of
>> each other:
>>
>> http://www.alsa-project.org/db/?f=c8a6fc8ced6993631bad6f754249454323422d1a
>>
> 
> speaker test or pulseaudio expect the "front volume" control the front
> jack (i.e. your HP jack) in surround 40 , 51 or 71
> 
> 

I see.

>>>
>>>
>>> Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
>>>   Control: name="Headphone Playback Switch", index=0, device=0
>>>     ControlAmp: chs=3, dir=Out, idx=0, ofs=0
>>>   Control: name="Headphone Jack", index=0, device=0
>>>   Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
>>>   Amp-In vals:  [0x00 0x00]
>>>   Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
>>>   Amp-Out vals:  [0x00 0x00]
>>>   Pincap 0x0001373e: IN OUT HP EAPD Detect Trigger
>>>     Vref caps: HIZ 50 GRD 80 100
>>>   EAPD 0x0:
>>>   Pin Default 0x0121101f: [Jack] HP Out at Ext Rear
>>>     Conn = 1/8, Color = Black
>>>     DefAssociation = 0x1, Sequence = 0xf
>>>   Pin-ctls: 0xc0: OUT HP VREF_HIZ
>>>   Unsolicited: tag=01, enabled=1
>>>   Power states:  D0 D1 D2 D3
>>>   Power: setting=D0, actual=D0
>>>   Connection: 5
>>>      0x0c 0x0d 0x0e 0x0f 0x26*
>>>
>>> The other method is using  "hp_pin" instead of "speaker_pin" to assign
>>> "Front" dac 0x02
>>>
>>> but this method won't create "headphone playback volume" and
>>> "Headphone playback switch" since "hp_pin" is used to create "Front
>>> Playback Volume" and "Front Playback Switch"
>>>
>>>
>>>>>>> Summing up, when it comes to P150HM, the only missing piece is the
>>>>>>> internal subwoofer. I tried emailing Andrew, who started this thread,
>>>>>>> but got no answer so far. The problem might be that we might need to
>>>>>>> figure out what is that THX TruStudio PRO is doing under Windows that
>>>>>>> makes the internal subwoofer work.
>>>>>>
>>>>>>
>>>>>> Take a look at the removed model="targa_8ch_dig" which touch those gpio
>>>>>>
>>>>>> Have you ask the notebook vendor clevo support/engineer the subwoofer
>>>>>> is connected to which pin of alc892 ?
>>>>>
>>>>> I have just sent an email to Clevo UK Support. Let's see what they answer.
>>>>
>>>> I was forwarded to realtek. Is there any way to figure it out ourselves?
>>>>
>>>>>
>>>
>>> The remaining unused output pin is 0x15 and 0x16
>>
>> Yes, this is what we figured earlier already. If P170hm is any similar,
>> 0x16 is the sub:
>> http://mailman.alsa-project.org/pipermail/alsa-devel/2011-August/042981.html
>> The problem is that, as opposed to 0x17, simply switching the pin from
>> in to out and unmuting it does not make sound come out of the subwoofer.
>> Can it be because the center/lfe channel is already assigned to the mic
>> pin? Or do you think that THX is doing some sort of pre-amplification
>> which we need to emulate?
>>
>> Julian
>>
> 
> change one of the unused pin to  speaker pin by hda-jack-retask
> 
> http://thread.gmane.org/gmane.linux.alsa.devel/92229

This program does not work on Fedora due to lack of gksu, so I think I
am limited to plain hda-analyer.

> 
> assign hp to get dac 0x02 instead of speaker_pins[0]
> 
> you have to assign your 0x14 speaker and one of the unused pin of  to
> spec->extra_out
> and increase spec->speaker_outs from 1 to 2
> 
> 
> 8fa7ab48acb636d24669dab291807b487dfb2804
> 
> ALSA: hda - Fix surround/CLFE headphone and speaker pins order

This requires code changes, right? I am afraid this is beyond my
skillset, I am a biologist, after all.

Julian

--------------040505080604060904040906
Content-Type: application/x-xz;
 name="dmesg.txt.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg.txt.xz"

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
--------------040505080604060904040906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040505080604060904040906--
