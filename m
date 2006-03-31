From: Adrian Bunk <bunk@stusta.de>
Subject: Re: snd-nm256: hard lockup on every second module load after powerup
Date: Fri, 31 Mar 2006 23:12:40 +0200
Message-ID: <20060331211240.GD22677@stusta.de>
References: <20060326054542.GA11961@hermes.uziel.local> <s5hveu0chvy.wl%tiwai@suse.de> <1143500400.1792.314.camel@mindpipe> <20060329144303.GA24146@hermes.uziel.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932359AbWCaVMo@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060329144303.GA24146@hermes.uziel.local>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Takashi Iwai <tiwai@suse.de>, lkml <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 29, 2006 at 04:43:03PM +0200, Christian Trefzer wrote:
> Hi Takashi, Lee,
> 
> 
> On Mon, Mar 27, 2006 at 05:59:59PM -0500, Lee Revell wrote:
> > On Mon, 2006-03-27 at 12:16 +0200, Takashi Iwai wrote:
> > > 
> > > Try 2.6.16-git tree.  Some patches for this problem are there. 
> > 
> > If this does not fix the problem then alsa-devel (cc'ed) is the best
> > list to discuss the issue.
> 
> Actually, the changes in Linus' current git have fixed the hang for me.
> Good job - thanks a lot, guys!
> 
> Kind regards,
> Chris

Takashi, would it be possible getting the fixes for this hard lookup 
into 2.6.16.2?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
