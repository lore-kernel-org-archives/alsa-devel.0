From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: Applied "ASoC: hdac_hdmi: Ensuring proper setting
 of output widget power state" to the asoc tree
Date: Mon, 15 Jan 2018 16:11:53 +0530
Message-ID: <20180115104153.GB18649@localhost>
References: <1515670468-9198-1-git-send-email-abhijeet.kumar@intel.com>
 <E1ea6ZJ-0003BS-KB@debutante>
 <20180112212012.GI21458@sirena.org.uk>
 <20180115061216.GS18649@localhost>
 <20180115103040.GB7333@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 24EC2266FBD
 for <alsa-devel@alsa-project.org>; Mon, 15 Jan 2018 11:37:37 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20180115103040.GB7333@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Abhijeet Kumar <abhijeet.kumar@intel.com>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Takashi Iwai <tiwai@suse.com>, Jeeja KP <jeeja.kp@intel.com>, Sandeep Tayal <sandeepx.tayal@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 15, 2018 at 10:30:40AM +0000, Mark Brown wrote:
> On Mon, Jan 15, 2018 at 11:42:16AM +0530, Vinod Koul wrote:
> > On Fri, Jan 12, 2018 at 09:20:12PM +0000, Mark Brown wrote:
> 
> > > I've dropped this because it caused a conflict with the topic/hdac-hdmi
> > > branch - can you please check what's going on there?  I merged that into
> > > the topic/intel branch so probably just a rebase is needed.
> 
> > I do not think this is ready yet. Takashi and me have few comments on
> > this...
> 
> There were comments on v1 but nobody responded to v2.

yeah we were still stuck on v1 :) I think Abhijeet will post an update once
we align..

-- 
~Vinod
