From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v5 3/4] ASoC: Intel - add makefile support
	for SKL driver
Date: Tue, 16 Jun 2015 20:52:28 +0530
Message-ID: <20150616152228.GW28601@localhost>
References: <1434040438-14535-1-git-send-email-vinod.koul@intel.com>
 <1434040438-14535-4-git-send-email-vinod.koul@intel.com>
 <20150615155752.GV18309@sirena.org.uk>
 <s5hmw00gby8.wl-tiwai@suse.de>
 <20150615185405.GA18309@sirena.org.uk>
 <20150616044458.GU28601@localhost>
 <20150616104346.GG18309@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2511B265817
 for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2015 17:20:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150616104346.GG18309@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 16, 2015 at 11:43:46AM +0100, Mark Brown wrote:
 
> > Second one is to actually make this in core, move the flag in legacy driver to
> > hdac parts and be used in legacy driver as well as anywhere else
> 
> That's good, of course - just have one config option for all HDA
> drivers.
Okay I will send that now and remove form here :)

Thanks
-- 
~Vinod
