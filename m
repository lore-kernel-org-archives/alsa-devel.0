From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: snd-nm256: hard lockup on every second module load after
	powerup
Date: Fri, 31 Mar 2006 16:53:13 -0500
Message-ID: <1143841995.27146.25.camel@mindpipe>
References: <20060326054542.GA11961@hermes.uziel.local>
	 <s5hveu0chvy.wl%tiwai@suse.de> <1143500400.1792.314.camel@mindpipe>
	 <20060329144303.GA24146@hermes.uziel.local>
	 <20060331211240.GD22677@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751336AbWCaVxS@vger.kernel.org>
In-Reply-To: <20060331211240.GD22677@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Christian Trefzer <ctrefzer@gmx.de>, Takashi Iwai <tiwai@suse.de>, lkml <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-03-31 at 23:12 +0200, Adrian Bunk wrote:
> > Actually, the changes in Linus' current git have fixed the hang for
> me.
> > Good job - thanks a lot, guys!
> > 
> > Kind regards,
> > Chris
> 
> Takashi, would it be possible getting the fixes for this hard lookup 
> into 2.6.16.2?
> 

Is a 225 line patch to fix a driver that's never worked appropriate for
-stable?

Lee
