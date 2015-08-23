From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 4/5] ALSA: hdac: Add support to enable SPIB
 for hdac ext stream
Date: Sun, 23 Aug 2015 11:17:13 +0530
Message-ID: <20150823054713.GU13546@localhost>
References: <1440173181-3150-1-git-send-email-vinod.koul@intel.com>
 <1440173181-3150-5-git-send-email-vinod.koul@intel.com>
 <55D761FA.9060201@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 226D5260470
 for <alsa-devel@alsa-project.org>; Sun, 23 Aug 2015 07:45:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <55D761FA.9060201@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 21, 2015 at 12:38:02PM -0500, Pierre-Louis Bossart wrote:
> weird function name. a set_spbmaxfifo that reads a value? Shouldn't
> it be a get?
Sorry it is my bad as I inserted get while correcting few other things in
this patch. I will send an update fixing these things as Takashi applied
this

-- 
~Vinod
