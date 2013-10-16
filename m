From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: Audio Miniconference 2013 schedule II - Edinburgh
	21st October
Date: Wed, 16 Oct 2013 16:09:39 +0530
Message-ID: <1381919979.8697.13.camel@katana>
References: <20131014161003.GC2443@sirena.org.uk>
 <20131015164408.GQ2954@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
 by alsa0.perex.cz (Postfix) with ESMTP id CCD80265134
 for <alsa-devel@alsa-project.org>; Wed, 16 Oct 2013 12:39:43 +0200 (CEST)
In-Reply-To: <20131015164408.GQ2954@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Colin Guthrie <colin@guthr.ie>, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@intel.com>, Tanu Kaskinen <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2013-10-15 at 22:14 +0530, Vinod Koul wrote:
> On Mon, Oct 14, 2013 at 05:10:03PM +0100, Mark Brown wrote:
> > Another go at the schedule for the mini-summit based on the feedback
> > last time.  Same three major topics:
> > 
> >  - Compressed audio review: tinycompress, integration into userspace,
> >    driver upstreaming.
> Sorry I am not going to make it the conf!
> 
> I will send out the status of offload, challanges, drivers (not many) before you
> guys start the meeting. Together with Eric's usermode and Android update it
> should cover well. I would have loved to see something on PA side too.
> 
> Arun any plans to implement support for compressed offload?

I am _very_ keen on this. My current Edinburgh plans are a bit up in the
air, while I wait for my visa (if it doesn't turn up by Friday, I can't
make it).

> >  - UCM and other use case management status & review (Tanu).
> > 
> >  - Effects offload to DSPs with dynamically instantiatable algorithms,
> >    and general dynamic DSP firmware handling including DSP resource
> >    management (Pierre).
> We are working on effect offloading part and creating framework in sound for
> DSPs to do that. Hopefully we should be able to push an RFC before this week and
> you guys with Pierre can discuss this over the meeting and provide feedback for
> future work on this topic

While not dependent on the ALSA bits per se, being able to integrate
this nicely into PA is also something that's very interesting to me.

If things do work out w.r.t. my travel, I'd definitely like to discuss
how we might go about doing these things in PA. If not, I hope there'll
be notes. :)

-- Arun
