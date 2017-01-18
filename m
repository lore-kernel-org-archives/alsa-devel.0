From: Jeeja KP <jeeja.kp@intel.com>
Subject: Re: [PATCH 00/30] ASoC: hdac_hdmi: Add support to
	enable MST audio
Date: Wed, 18 Jan 2017 18:14:04 +0530
Message-ID: <20170118124403.GA9491@kpjeeja-desk>
References: <1484589477-7630-1-git-send-email-jeeja.kp@intel.com>
 <20170117175442.knusnvczrh56o5d2@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id BC1F32676C6
 for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2017 13:32:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170117175442.knusnvczrh56o5d2@sirena.org.uk>
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
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 17, 2017 at 05:54:42PM +0000, Mark Brown wrote:
> On Mon, Jan 16, 2017 at 11:27:27PM +0530, jeeja.kp@intel.com wrote:
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > Display port 1.2 introduces new capability Multi-stream transport (MST)
> > which will allow multiple stream to route to single display port where
> > multiple monitors are connected. Multiple monitors will be connected by
> > a MST Hub or a monitor capable of daisy-chaining.
> 
> This is a *really* big patch series.  As I've said before please try to
> keep patch serieses down to a manageable size, 20 patches is getting
> quite large and this is quite a bit bigger.  It's a lot easier for
> people to digest things in smaller chunks and it's a lot easier to push
> something enormous that's going to take time to get through to the back
> of the queue when you're short on time.
i will split the patch series and post it again.
-- 
