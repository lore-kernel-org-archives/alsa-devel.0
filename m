From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: mm snapshot broken-out-2007-03-05-02-22.tar.gz
	uploaded
Date: Thu, 8 Mar 2007 17:23:34 +0100
Message-ID: <6bffcb0e0703080823ybb4ceaasd229ba17cb2d40d6@mail.gmail.com>
References: <200703051024.l25AOIF3015951@shell0.pdx.osdl.net>
	<45EEA3C4.7000501@googlemail.com>
	<20070307104746.f08a2e84.akpm@linux-foundation.org>
	<6bffcb0e0703071141j42309702w793e4a76b1b23bfa@mail.gmail.com>
	<20070307115024.756c848f.akpm@linux-foundation.org>
	<s5hvehcrdod.wl%tiwai@suse.de> <45EF3B2C.9060801@googlemail.com>
	<s5hfy8gbrmj.wl%tiwai@suse.de> <45F02EE2.6040606@googlemail.com>
	<s5hbqj3ohgb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C59A2438D
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2007 17:23:37 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 67so918428wri
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2007 08:23:35 -0800 (PST)
In-Reply-To: <s5hbqj3ohgb.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On 08/03/07, Takashi Iwai <tiwai@suse.de> wrote:
> At Thu, 08 Mar 2007 16:42:26 +0100,
> Michal Piotrowski wrote:
> >
> > > Also, it'd be helpful if you compare
> > > /proc/asound/card0/codec97#0/ac97#0-0+regs file before and after the
> > > patch.  This reveals which register bits differ actually.
> >
> > a2.txt is form 2.6.21-rc3 witchout 831466f4ad2b5fe23dff77edbe6a7c244435e973
>
> Just to make sure: it means that a2.txt is a working one and the
> anoter is non-working, right?

Right.

>
>
> Takashi
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group (PL)
(http://www.stardust.webpages.pl/ltg/)
LTG - Linux Testers Group (EN)
(http://www.stardust.webpages.pl/linux_testers_group_en/)

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
