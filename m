From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: hdsp multiface.
Date: Thu, 03 Jul 2003 01:53:06 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F030DF2.8070900@boosthardware.com>
References: <NDBBLGIKBJENLAMOLFHGOEEICKAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www3.webhosting.cx (IDENT:ZKRujQTZ5DMx6bzItXgcU+9T5EykjAU4@www3.webhosting.cx [207.44.248.26])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA06321
	for <alsa-devel@alsa-project.org>; Wed, 2 Jul 2003 19:34:58 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Knecht wrote:
>>Card 1 : RME Hammerfall DSP (Multiface) at 0xe9000000, irq 11
>>Upload firmware for card hw:1
>>Error opening hwdep device on card hw:1.
>>
>>Either way I still get this message from aplay:
>>
>>aplay -f cd -D hw:1,0 /art/1REC/020403-studio.wav
>>Playing WAVE '/art/1REC/020403-studio.wav' : Signed 16 bit Little
>>Endian, Rate 44100 Hz, Stereo
>>aplay: set_params:800: Access type not available
>>
> 
> 
> Partick,
> 
> Sorry for butting in...
> 
> Is this similar to the problems Jesse Chappell was having? If so, his
> 'solution' ;-) was to boot Windows to get the firmware loaded, and then to
> warm boot into Linux to actually use the card.
> 

I'll check the archive but I don't have windows and won't ever on that 
computer so it would be much nicer if it just worked. I would rather go 
back to an old driver than install windohs.


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
