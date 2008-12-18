From: Liam Girdwood <lrg@kernel.org>
Subject: Re: [PATCH 4/4] ASoC: Add WM8350 AudioPlus codec driver
Date: Thu, 18 Dec 2008 19:02:07 +0000
Message-ID: <1229626928.24727.1304.camel@vega.slimlogic.co.uk>
References: <20081218173021.GA25332@rakim.wolfsonmicro.main>
	<1229621458-2144-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1229621458-2144-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1229621458-2144-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1229621458-2144-4-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 8792C24479
	for <alsa-devel@alsa-project.org>; Thu, 18 Dec 2008 20:02:15 +0100 (CET)
In-Reply-To: <1229621458-2144-4-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2008-12-18 at 17:30 +0000, Mark Brown wrote:
> The WM8350 is an integrated audio and power management subsystem which
> provides a single-chip solution for portable audio and multimedia systems.
> 
> The integrated audio CODEC provides all the necessary functions for
> high-quality stereo recording and playback. Programmable on-chip
> amplifiers allow for the direct connection of headphones and microphones
> with a minimum of external components. A programmable low-noise bias
> voltage is available to feed one or more electret microphones.
> Additional audio features include programmable high-pass filter in the
> ADC input path.
> 
> This driver was originally written by Liam Girdwood with further updates
> from me.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Signed-off-by: Liam Girdwood <lrg@slimlogic.co.uk>

Liam
