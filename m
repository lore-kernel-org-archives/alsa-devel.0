From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: usb audio sound quality
Date: Fri, 08 Nov 2002 19:17:16 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DCB8F2C.4060402@boosthardware.com>
References: <Pine.LNX.4.44.0211060959140.1126-100000@cmn37.stanford.edu> <3DC97C55.6000507@boosthardware.com> <3DCAE7C8.5030808@boosthardware.com> <3DCB8155.5000202@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id LAA05837
	for <alsa-devel@alsa-project.org>; Fri, 8 Nov 2002 11:28:32 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> 
> I guess that ssm (and possibly JACK) has some mem leaks. 
> 

It seems I spoke too soon. I'm seeing memory leaks while using 
alsaplayer or xmms. Alsaplayer connected via the alsa driver and xmms 
through oss.

I'm going through about 1 MB/min :(

Is this an alsa issue or should I be looking on the usb lists, going for 
a new kernel...?



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
