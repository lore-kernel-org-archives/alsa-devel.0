From: Tino Keitel <tino.keitel@gmx.de>
Subject: Re: 2.6.29 regression: left audio channel broken after resume from
	suspend with Intel HDA
Date: Thu, 7 May 2009 00:27:53 +0200
Message-ID: <20090506222753.GA6728@mac.home>
References: <s5hmyab15bh.wl%tiwai@suse.de> <20090420194659.GA11399@dose.home.local> <s5h8wluinon.wl%tiwai@suse.de> <20090421073219.GA5866@dose.home.local> <s5hfxg2cv6m.wl%tiwai@suse.de> <20090421183936.GA21935@dose.home.local> <s5hws9a5ewr.wl%tiwai@suse.de> <20090424142113.GA18668@dose.home.local> <s5hskjy5d2t.wl%tiwai@suse.de> <20090428002309.GA29572@x61>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762150AbZEFW2b@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090428002309.GA29572@x61>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 28, 2009 at 02:23:09 +0200, Tino Keitel wrote:

[...]

> I just saw another, major problem: line in doesn't work anymore with
> 2.6.29 and also 2.6.30-rc3 (no usable input level). It works with
> 2.6.27.20.

FYI: I just tried 2.6.28 and line-in was still broken. So the last
working kernel is 2.6.27.

Regards,
Tino
