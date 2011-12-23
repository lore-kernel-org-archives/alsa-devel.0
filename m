From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH v5 0/6] core: add compress data API to ALSA
	kernel
Date: Fri, 23 Dec 2011 17:07:37 +0530
Message-ID: <1324640257.1641.10140.camel@vkoul-udesk3>
References: <1323070791-12620-1-git-send-email-vinod.koul@linux.intel.com>
	<1324616800-19749-1-git-send-email-vinod.koul@linux.intel.com>
	<s5hd3bfocgs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 7761A103FA9
	for <alsa-devel@alsa-project.org>; Fri, 23 Dec 2011 12:37:36 +0100 (CET)
In-Reply-To: <s5hd3bfocgs.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-12-23 at 10:37 +0100, Takashi Iwai wrote:
> At Fri, 23 Dec 2011 10:36:34 +0530,
> Vinod Koul wrote:
> > 
> > As agreed during the ASoC workshop in May 2011, this set of patches are a
> > proposal from Intel to add a new compressed data interface to ALSA. This
> > proposal builds on the existing Intel solution and the experience gathered over
> > two years with Meego and Android solutions. This proposal is no longer
> > Intel-specific and was generalized with the addition of a basic core;
> > codec-related definitions are based on the vendor-neutral OpenMAX AL standard. 
> > 
> > These patches are also available in git tree:
> > git://git.infradead.org/users/vkoul/snd-compress.git v5_patches
> 
> I applied all patches now.  Please check later the sound git tree
> whether everything is OK.
Thanks Takashi.

Checked the patches looks fine.
I will also test from your tree and (clone in progress) and let you know
as well

Thanks
-- 
~Vinod
