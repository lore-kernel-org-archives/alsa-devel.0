From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 0/5] ALSA - hda: Add support for link
 audio	time reporting
Date: Wed, 10 Aug 2016 08:35:35 +0530
Message-ID: <20160810030535.GB9681@localhost>
References: <1470305764-20802-1-git-send-email-vinod.koul@intel.com>
 <s5hlh0b5s8r.wl-tiwai@suse.de>
 <20160805121655.GX10383@sirena.org.uk>
 <s5hinvf5rlw.wl-tiwai@suse.de> <s5hwpjqmno9.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id B7CA3265857
 for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2016 04:57:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwpjqmno9.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 09, 2016 at 09:00:54AM +0200, Takashi Iwai wrote:
> On Fri, 05 Aug 2016 14:26:35 +0200,
> Takashi Iwai wrote:
> > 
> > On Fri, 05 Aug 2016 14:16:55 +0200,
> > Mark Brown wrote:
> > > 
> > > On Fri, Aug 05, 2016 at 02:12:52PM +0200, Takashi Iwai wrote:
> > > 
> > > > Mark, please merge back to your intel topic branch later if needed.
> > > 
> > > Can you let me know when there's a tag for it please?
> > 
> > It's not published yet.  I'm going to publish after rebasing onto
> > 4.8-rc1 and ping you again.
> 
> Pushed to topic/hda-link-time branch.

Thanks :)

> BTW, now all the feature of hammock harbor has been implemented in the
> kernel side?  Or any patch missing?

Yes from my side we are done for HDA part. I2S part for asoc driver will
follow sometime later.

-- 
~Vinod
