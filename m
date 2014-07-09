From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: wm-adsp: Add missing MODULE_LICENSE
Date: Wed, 9 Jul 2014 22:09:40 +0530
Message-ID: <20140709163940.GB2296@intel.com>
References: <1404452861-8951-1-git-send-email-vinod.koul@intel.com>
 <20140704114723.GB19453@sirena.org.uk>
 <20140704124724.GA16644@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F45C261ABD
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 18:41:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20140704124724.GA16644@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Praveen Diwakar <praveen.diwakar@intel.com>, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 04, 2014 at 01:47:24PM +0100, Charles Keepax wrote:
> On Fri, Jul 04, 2014 at 12:47:23PM +0100, Mark Brown wrote:
> > On Fri, Jul 04, 2014 at 11:17:41AM +0530, Vinod Koul wrote:
> > > From: Praveen Diwakar <praveen.diwakar@intel.com>
> > > 
> > > Since MODULE_LICENSE is missing the module load fails,
> > > so add this for module.
> > 
> > Always CC maintainers on patches (in this case the Wolfson people),
> > especially for something like licensing.
> 
> Indeed we would definitely like to be in the loop on licensing
> changes :-)
Sorry about missing you folks on this. Somehow still mind equated wm with Mark.

We should let get_maintainers do this, always :)

-- 
~Vinod
