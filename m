From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH 10/19] ASoC: upd9976: add microphone bias
	support
Date: Thu, 5 May 2011 08:40:27 +0800
Message-ID: <20110505004027.GE8633@qtel.sh.intel.com>
References: <20110504133756.32443.6282.stgit@localhost>
	<20110504134544.32443.43029.stgit@localhost>
	<20110504162534.GH10912@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id DD35510393D
	for <alsa-devel@alsa-project.org>;
	Thu,  5 May 2011 02:41:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110504162534.GH10912@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, "Koul, Vinod" <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, "Wang, Xingchao" <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 05, 2011 at 12:25:34AM +0800, Mark Brown wrote:
> On Wed, May 04, 2011 at 09:45:44PM +0800, Lu Guanqun wrote:
> > Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>
> 
> In general for most of these things just squash them into the original
> driver for submission, no point in splitting them out if you're not
> actually doing initial submission.

OK. I was trying to split things into smaller patches so that you
maintainers have a easier time to review them.

So in the next version, there will be less number of patches. :)

-- 
guanqun
