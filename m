From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: RME HDSP 9652 vs DIGI 9652
Date: Fri, 25 Jul 2003 07:11:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E19g0NT-0002iL-00@sc8-sf-list1.sourceforge.net>
References: <1059100074.3f2095aaafe13@webdjn.unm.edu>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 24 Jul 2003 20:27:54 MDT."
             <1059100074.3f2095aaafe13@webdjn.unm.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Sheltraw <sheltraw@unm.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Are the registers of RME HDSP 9652 and DIGI 9652 identical. If

no, not at all, although there are similarities.

>not does anyone have datasheets for the HDSP 9652. I need them
>for a custom application and I just noticed that RME discontinued
>the DIGI 9652. If not, do you have an email address for the RME
>engineer that could provide the datasheets.

there was never a datasheet. the source code to the ALSA driver
provides all the information i ever received from RME, plus quite a
bit more learnt from experience. use the source for the rme9652.c
driver. 

--p



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
