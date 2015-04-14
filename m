From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 05/11] ALSA: hda - exported link_reset
	enter/exit
Date: Tue, 14 Apr 2015 10:07:29 +0530
Message-ID: <20150414043729.GG2963@intel.com>
References: <1428842178-7105-1-git-send-email-subhransu.s.prusty@intel.com>
 <1428842178-7105-6-git-send-email-subhransu.s.prusty@intel.com>
 <s5h4mokp73j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 638B5260478
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 06:42:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4mokp73j.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, broonie@kernel.org, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 13, 2015 at 02:04:32PM +0200, Takashi Iwai wrote:
> At Sun, 12 Apr 2015 18:06:12 +0530,
> Subhransu S. Prusty wrote:
> > 
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > Exported azx_enter_link_reset and azx_exit_link_reset
> > functions to be used by the SKL controller driver
> 
> OK, I can fold them to my patchset.
Sounds good :)

-- 
~Vinod
