From: Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [alsa-devel] channel swapping issue on OMAP3/TWL4030 is back
Date: Fri, 22 Mar 2013 10:56:35 +0100 (CET)
Message-ID: <alpine.DEB.2.01.1303221023070.7975@pmeerw.net>
References: <alpine.DEB.2.01.1303220932150.7975@pmeerw.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.01.1303220932150.7975@pmeerw.net>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


> I'm running Linux 3.7 on a beagle-xm and observe very reproducible stereo 
> channel swapping issue on playback of a stereo stream (one channel has a 
> sine, the other is zero); the channel swap occurs on starting the playback

> it appears that the swapping issue is back, probably due to the DMA rework 
> in recent kernel?

kernel 3.4 does not have the issue

regards, p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
