From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] compress: add support for gapless playback
Date: Thu, 14 Feb 2013 16:36:49 +0530
Message-ID: <20130214110649.GA29960@intel.com>
References: <1360831371-27602-1-git-send-email-vinod.koul@intel.com>
 <s5hip5vtfze.wl%tiwai@suse.de> <20130214093244.GA27887@intel.com>
 <s5hfw0ztei5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D2D0D2652EF
 for <alsa-devel@alsa-project.org>; Thu, 14 Feb 2013 12:07:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hfw0ztei5.wl%tiwai@suse.de>
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
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 14, 2013 at 10:45:54AM +0100, Takashi Iwai wrote:
> Another favor would be to have a bit more comments about the existing
> metadata parameter definitions, namely, what's exactly expected, in
> which unit, and how many values are used (now we have an array).
> This can be put in either compress API document or a short comment in
> the enum item definition.
I had that in one of the rev... let me update it.
I feel header is best suited...

You lost on the beverage :)

--
~Vinod
