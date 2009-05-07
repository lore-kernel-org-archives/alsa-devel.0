From: Tino Keitel <tino.keitel@gmx.de>
Subject: Re: 2.6.29 regression: left audio channel broken after resume from
	suspend with Intel HDA
Date: Thu, 7 May 2009 22:53:49 +0200
Message-ID: <20090507205349.GA12089@mac.home>
References: <s5hfxg2cv6m.wl%tiwai@suse.de> <20090421183936.GA21935@dose.home.local> <s5hws9a5ewr.wl%tiwai@suse.de> <20090424142113.GA18668@dose.home.local> <s5hskjy5d2t.wl%tiwai@suse.de> <20090428002309.GA29572@x61> <20090506222753.GA6728@mac.home> <20090507072352.GA6513@mac.home> <s5hy6t92nuz.wl%tiwai@suse.de> <20090507204208.GA20465@mac.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1753801AbZEGUyG@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090507204208.GA20465@mac.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, May 07, 2009 at 22:42:08 +0200, Tino Keitel wrote:
> On Thu, May 07, 2009 at 12:45:08 +0200, Takashi Iwai wrote:
> 
> [...]
> 
> > Could you try the patch below instead?
> 
> It doesn't work.

Sorry, my mixer setup was wrong. The patch works.

Regards,
Tino
