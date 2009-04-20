From: Tino Keitel <tino.keitel@tikei.de>
Subject: Re: 2.6.29 regression: left audio channel broken after resume from
	suspend with Intel HDA
Date: Mon, 20 Apr 2009 21:46:59 +0200
Message-ID: <20090420194659.GA11399@dose.home.local>
References: <20090420184024.GA10155@dose.home.local> <s5hmyab15bh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756255AbZDTTrT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hmyab15bh.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 20, 2009 at 21:41:06 +0200, Takashi Iwai wrote:

[...]

> Could you try the latest Linus git tree?  A fix patch was merged
> after 2.6.30-rc2.  The patch will be merged to later stable kernel, too.

What commit is this? Can it be applied to 2.6.29? As it isn't perfectly
reproducable, I'd like to run 2.6.29 with the patch applied and see if
the problem disappears.

Regards,
Tino
