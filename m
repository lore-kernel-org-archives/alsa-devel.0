From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: mm snapshot broken-out-2007-03-05-02-22.tar.gz
	uploaded
Date: Thu, 8 Mar 2007 17:26:48 +0100
Message-ID: <6bffcb0e0703080826l1e5eb42fv68ed27d79ad74663@mail.gmail.com>
References: <200703051024.l25AOIF3015951@shell0.pdx.osdl.net>
	<45EEA3C4.7000501@googlemail.com>
	<20070307104746.f08a2e84.akpm@linux-foundation.org>
	<6bffcb0e0703071141j42309702w793e4a76b1b23bfa@mail.gmail.com>
	<20070307115024.756c848f.akpm@linux-foundation.org>
	<s5hvehcrdod.wl%tiwai@suse.de> <45EF3B2C.9060801@googlemail.com>
	<s5hfy8gbrmj.wl%tiwai@suse.de> <45F02EE2.6040606@googlemail.com>
	<s5hd53johlw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 69BEC2438E
	for <alsa-devel@alsa-project.org>; Thu,  8 Mar 2007 17:26:50 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id j3so958508ugf
	for <alsa-devel@alsa-project.org>; Thu, 08 Mar 2007 08:26:49 -0800 (PST)
In-Reply-To: <s5hd53johlw.wl%tiwai@suse.de>
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
> > Takashi Iwai napisa=B3(a):
> > > Or, does it happen if you play a real 5.1 channel file?
> > > (for example, try speaker-test -c6)
> >
> > It doesn't work for me on both kernels.
>
> Pass -Dplug:surround51 to speaker-test in addition.

It still doesn't work (at least on clean 2.6.21-rc3).

Regards,
Michal

-- =

Michal K. K. Piotrowski
LTG - Linux Testers Group (PL)
(http://www.stardust.webpages.pl/ltg/)
LTG - Linux Testers Group (EN)
(http://www.stardust.webpages.pl/linux_testers_group_en/)
-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
