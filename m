From: Richard Kettlewell <rjk@greenend.org.uk>
Subject: Re: mixer API documentation
Date: Tue, 13 Nov 2007 20:08:45 +0000
Message-ID: <wwvwssl3o36.fsf@rjk.greenend.org.uk>
References: <wwvmytvjtmk.fsf@rjk.greenend.org.uk>
	<s5hbq9yv1cu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from chiark.greenend.org.uk (chiark.greenend.org.uk [212.13.197.229])
	by alsa0.perex.cz (Postfix) with ESMTP id B5E53245DC
	for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2007 21:09:31 +0100 (CET)
Received: from [172.17.207.6] (helo=sfere.anjou.terraraq.org.uk
	ident=Debian-exim)
	by chiark.greenend.org.uk (Debian Exim 3.36 #1) with esmtp
	(return-path richard@sfere.greenend.org.uk) id 1Is24h-0003C0-00
	for alsa-devel@alsa-project.org; Tue, 13 Nov 2007 20:09:31 +0000
In-Reply-To: <s5hbq9yv1cu.wl%tiwai@suse.de>
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

Takashi Iwai writes:
> At Sat, 3 Nov 2007 14:22:59 +0000,
> Richard Kettlewell wrote:
> > 
> > Hello,
> > 
> > Where is the ALSA mixer API documentation?  I looked at
> > http://www.alsa-project.org/alsa-doc/alsa-lib/mixer.html, but that
> > only says "Mixer interface is designed to access the abstracted mixer
> > controls. This is an abstraction layer over the hcontrol layer".
> 
> The mixer interface isn't well documented than others, unfortunately.

I'll stick with OSS emulation until someone can be bothered to
document ALSA then.

> You can find brief description of each function and data definition
> in the module section
> 
> 	http://www.alsa-project.org/alsa-doc/alsa-lib/group___mixer.html
> 
> and "Simple Mixer" section there.

ttfn/rjk
