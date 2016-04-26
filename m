From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH v3 0/9] ASoC: hdac_hdmi: Add multichannel
	support
Date: Tue, 26 Apr 2016 17:24:45 +0530
Message-ID: <20160426115440.GA13732@subhransu-desktop>
References: <1460608656-8860-1-git-send-email-subhransu.s.prusty@intel.com>
 <20160426044917.GB10261@subhransu-desktop>
 <20160426110954.GV3217@sirena.org.uk>
 <s5hmvogsiao.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id D2E242608B3
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 13:56:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hmvogsiao.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 26, 2016 at 01:47:43PM +0200, Takashi Iwai wrote:
> On Tue, 26 Apr 2016 13:09:54 +0200,
> Mark Brown wrote:
> > 
> > On Tue, Apr 26, 2016 at 10:19:18AM +0530, Subhransu S. Prusty wrote:
> > 
> > > How are you planning to merge this, will you merge takashi tree or you
> > > want this to be merged thru his tree? We prefer former as that would
> > > reduce conflicts for upcoming patches.
> > 
> > I've not even looked at this since patch 2 is a generic HDA change and
> > hasn't been reviewed yet.
> 
> That one is fine, it's a revised version after my initial review to
> v1.  So feel free to take my ack for patch 2:
>   Acked-by: Takashi Iwai <tiwai@suse.de>

Thanks Takashi.

Regards,
Subhransu
> 
> 
> Takashi

-- 
