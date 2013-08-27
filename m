From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/9] ALSA: compress offfload fixes
Date: Tue, 27 Aug 2013 19:11:46 +0530
Message-ID: <20130827134146.GE2748@intel.com>
References: <1377585639-29516-1-git-send-email-vinod.koul@intel.com>
 <s5heh9fjtrn.wl%tiwai@suse.de> <20130827100955.GX2748@intel.com>
 <s5h7gf7jov7.wl%tiwai@suse.de> <20130827131438.GA2748@intel.com>
 <s5hwqn7i5zj.wl%tiwai@suse.de> <20130827133030.GD2748@intel.com>
 <s5htxibi574.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C960E260865
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 16:26:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5htxibi574.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 27, 2013 at 04:22:39PM +0200, Takashi Iwai wrote:
> I understand it, but my question is what fixes your patch except for
> the comment in the header file?  In other words, by changing the
> comment text, what will be fixed in the end?
the meaning and API version which tinycompress will use to send right values..

~Vinod
