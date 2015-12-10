From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 05/13] ASoC: wm_adsp: Select
	SND_SOC_COMPRESS
Date: Thu, 10 Dec 2015 13:49:00 +0000
Message-ID: <20151210134900.GP6058@localhost.localdomain>
References: <1449590917-21170-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1449590917-21170-5-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20151210080947.GS1854@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 67542265341
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 14:49:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151210080947.GS1854@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 10, 2015 at 01:39:47PM +0530, Vinod Koul wrote:
> On Tue, Dec 08, 2015 at 04:08:29PM +0000, Charles Keepax wrote:
> > Additions to the DSP mean we will need to include support for the
> > compressed framework. This patch selects SND_SOC_COMPRESS.
> 
> probably this should be sqashed to the 6th one where you add the compress DAI

yeah no problem with squashing those, I will wait I while for any
more comments then send a new version.

Thanks,
Charles
