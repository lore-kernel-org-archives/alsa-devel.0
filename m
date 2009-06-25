From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.32
Date: Thu, 25 Jun 2009 13:49:19 +0100
Message-ID: <20090625124918.GA8856@sirena.org.uk>
References: <20090625102141.GA17812@sirena.org.uk>
	<s5hmy7wa9bt.wl%tiwai@suse.de>
	<20090625110121.GE17812@sirena.org.uk>
	<s5heit8a4q3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C3C110383F
	for <alsa-devel@alsa-project.org>;
	Thu, 25 Jun 2009 14:49:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5heit8a4q3.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 25, 2009 at 02:16:20PM +0200, Takashi Iwai wrote:

> upstream is merged into ASoC, the whole upstream commits are shown
> first, then following ASoC commits.  When ASoC is merged into an
> upstream, then the result becomes reversed.  So, it's clear that the
> merge started from that upstream point.

Meh, OK. 

It'd help me in future if you could either give some warning of the
upstream merges or do them only immediately after pulling.  The issue
here from my point of view is that you've already merged up 2.6.31 into
your branch and I routinely pull in changes on the topic branch for
obvious reasons.  I have this process semi-automated (and want to get it
more so) so some warning would help.
