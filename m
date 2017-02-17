From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 15/16] ASoC: Intel: bxt: Add jack port
 initialize in bxt_rt298 machine
Date: Fri, 17 Feb 2017 07:40:42 +0530
Message-ID: <20170217021042.GS2843@localhost>
References: <1486474800-11426-1-git-send-email-jeeja.kp@intel.com>
 <1486474800-11426-16-git-send-email-jeeja.kp@intel.com>
 <20170216185658.relwcxkr357dqjhs@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id AD6422670BE
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 03:10:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170216185658.relwcxkr357dqjhs@sirena.org.uk>
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
Cc: tiwai@suse.de, jeeja.kp@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 16, 2017 at 06:56:58PM +0000, Mark Brown wrote:
> On Tue, Feb 07, 2017 at 07:09:59PM +0530, jeeja.kp@intel.com wrote:
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > After the pcm jack is created, create and initialize the pin switch
> > widget for each port. Pin switch is to enable/disable the pin when
> > monitor is connected/disconnected.
> > ---
> 
> This has no signoffs at all, I can't do anything with it.  Vinod, you
> acked this?

Yeah sorry for the blunder :(

Not sure how that happended... Will ensure this never repeats.

Thanks
-- 
~Vinod
