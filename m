From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Applied "ASoC: hdac_hdmi: Ensuring proper setting of output
 widget power state" to the asoc tree
Date: Mon, 15 Jan 2018 11:42:16 +0530
Message-ID: <20180115061216.GS18649@localhost>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
 <E1ea6ZJ-0003BS-KB@debutante>
 <20180112212012.GI21458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180112212012.GI21458@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Abhijeet Kumar <abhijeet.kumar@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Sandeep Tayal <sandeepx.tayal@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 12, 2018 at 09:20:12PM +0000, Mark Brown wrote:
> On Fri, Jan 12, 2018 at 09:08:53PM +0000, Mark Brown wrote:
> > The patch
> > 
> >    ASoC: hdac_hdmi: Ensuring proper setting of output widget power state
> > 
> > has been applied to the asoc tree at
> > 
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 
> 
> I've dropped this because it caused a conflict with the topic/hdac-hdmi
> branch - can you please check what's going on there?  I merged that into
> the topic/intel branch so probably just a rebase is needed.

Hey Mark,

I do not think this is ready yet. Takashi and me have few comments on
this...

-- 
~Vinod
