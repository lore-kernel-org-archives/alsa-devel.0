From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [uclinux-dist-devel] [PATCH] ASoC: Blackfin TDM:
 fix missed snd_soc_dai_get_drvdata update
Date: Thu, 13 Jan 2011 17:12:49 +0000
Message-ID: <20110113171249.GH30351@opensource.wolfsonmicro.com>
References: <1294805299-5265-1-git-send-email-vapier@gentoo.org>
	<20110113135525.GD11840@opensource.wolfsonmicro.com>
	<AANLkTi=5z0u3un8mGoFChMyzgeGY-tajr3iCC-aR6Dv6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 99EF324681
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 18:15:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTi=5z0u3un8mGoFChMyzgeGY-tajr3iCC-aR6Dv6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 13, 2011 at 11:52:02AM -0500, Mike Frysinger wrote:
> On Thu, Jan 13, 2011 at 08:55, Mark Brown wrote:

> > Ccing in Liam - Mike, please remember to CC maintainers on patches - and
> > dropping the stable lists for now.

> i thought you were the ASoC maintainer

We comaintain ASoC, we generally both review everything except during
vacations.
