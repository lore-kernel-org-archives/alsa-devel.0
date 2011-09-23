From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [RFC 4/5] compress: add the core file
Date: Fri, 23 Sep 2011 16:37:25 +0530
Message-ID: <1316776045.1573.43.camel@vkoul-udesk3>
References: <1314943585-11670-1-git-send-email-vinod.koul@linux.intel.com>
	<1314943585-11670-5-git-send-email-vinod.koul@linux.intel.com>
	<20110922130132.GA10125@opensource.wolfsonmicro.com>
	<1316756471.1573.22.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 4FE4324373
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Sep 2011 13:12:04 +0200 (CEST)
In-Reply-To: <1316756471.1573.22.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-09-23 at 11:11 +0530, Vinod Koul wrote:
> On Thu, 2011-09-22 at 14:01 +0100, Dimitris Papastamos wrote:
> > 
> > Hi Vinod,
> > 
> > Any chance you could share your latest changes somehow?  It'd be worth
> > setting up a repository for further development on this.  I've got some
> > patches sitting locally, some of them are bug fixes, some others are
> > expected to mess with the API itself.
> > 
> Sure, let me setup a repo with above patches and current changes.
> Btw we have already fixed the comments you and other had given on this
> RFC. 
All,

I am staging the current wip code for compressed path API at
git://git.infradead.org/users/vkoul/snd-compress.git snd_compress

Currently it contains the RFC posted sometime back, fixes identified on
RFC and few during discussion in LPC

Patches/comments are welcome!

-- 
~Vinod
