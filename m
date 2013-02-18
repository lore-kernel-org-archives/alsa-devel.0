From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/2] ASoC: compress - add support for
	metadata apis
Date: Mon, 18 Feb 2013 19:05:13 +0530
Message-ID: <20130218133513.GA10950@intel.com>
References: <1361183381-30010-1-git-send-email-vinod.koul@intel.com>
 <20130218131928.GB30157@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CB4626501A
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2013 14:36:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130218131928.GB30157@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 18, 2013 at 01:19:28PM +0000, Mark Brown wrote:
> On Mon, Feb 18, 2013 at 03:59:40PM +0530, Vinod Koul wrote:
> 
> > Mark, Takashi:
> > How do you guys wnat to take this one, Ideally this should go to mark's tree but
> > the dependent apis are in takashi's tree, either way is fine with me :)
> 
> Since we're expecting the merge window to open today or something
> probably the easiest thing is for me to apply it after -rc1?
okay, but it can go via takashi's tree after he merges asoc updates from you.
Since core support is getting into linus's tree in merge window it would make
sense for ASoC and driver update to go along as well.

--
~Vinod
