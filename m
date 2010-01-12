From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.34
Date: Tue, 12 Jan 2010 14:14:48 +0000
Message-ID: <20100112141448.GI1418@rakim.wolfsonmicro.main>
References: <20100112132002.GC1418@rakim.wolfsonmicro.main>
	<s5hockzmo1t.wl%tiwai@suse.de>
	<20100112140936.GH1418@rakim.wolfsonmicro.main>
	<201001121612.41952.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6FE151038AE
	for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2010 15:14:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201001121612.41952.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 12, 2010 at 04:12:41PM +0200, Peter Ujfalusi wrote:
> On Tuesday 12 January 2010 16:09:37 ext Mark Brown wrote:

> > What config do you use to generate these warnings?  None of mine
> > generate them.

> I have not seen them either, but I will send a patch for the tpa and dac33, and 
> add the __devexit and __devinit to *_probe *_remove.

It's OK, I've done that patch already.
