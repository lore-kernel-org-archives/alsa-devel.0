From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2.6.27?] ASoC: Correct inverted Mic PGA
	Switch control	in wm8510 driver
Date: Tue, 7 Oct 2008 11:22:25 +0100
Message-ID: <20081007102225.GA25262@rakim.wolfsonmicro.main>
References: <1223289201-29091-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5hwsgkomow.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1B61724455
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 12:22:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwsgkomow.wl%tiwai@suse.de>
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

On Tue, Oct 07, 2008 at 10:04:47AM +0200, Takashi Iwai wrote:

> Applied now to asoc-fixes branch.
> Not sure whether I'll send more push request at this stage, though...

It's not the end of the world if it doesn't go - it's trivial to work
around in user space or backport.
