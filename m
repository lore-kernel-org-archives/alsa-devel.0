From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 05/10] ASoC: upd9976: add DMIC support
Date: Fri, 6 May 2011 12:07:31 +0100
Message-ID: <20110506110730.GG23729@opensource.wolfsonmicro.com>
References: <20110506053852.26312.79083.stgit@localhost>
	<20110506054624.26312.30651.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 05187103A66
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 13:07:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110506054624.26312.30651.stgit@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Koul Vinod <vinod.koul@intel.com>, ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 06, 2011 at 01:46:24PM +0800, Lu Guanqun wrote:
> Signed-off-by: Lu Guanqun <guanqun.lu@intel.com>

As previously mentioned please merge these trivial feature patches into
the original driver unless there's some purpose in splitting them out.
In this case it looks like the split is the cause of one of the review
issues in the earlier post.
