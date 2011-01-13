From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [uclinux-dist-devel] [PATCH] ASoC: Blackfin TDM:
 fix missed snd_soc_dai_get_drvdata update
Date: Thu, 13 Jan 2011 12:17:15 -0500
Message-ID: <AANLkTi=Uf_uFT46fDrgQcwrwiO8GOGhxs_PZJEcG7XxY@mail.gmail.com>
References: <1294805299-5265-1-git-send-email-vapier@gentoo.org>
	<20110113135525.GD11840@opensource.wolfsonmicro.com>
	<AANLkTi=5z0u3un8mGoFChMyzgeGY-tajr3iCC-aR6Dv6@mail.gmail.com>
	<20110113171249.GH30351@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 57F07103B3F
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 18:18:09 +0100 (CET)
Received: by eyg24 with SMTP id 24so920171eyg.38
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2011 09:18:09 -0800 (PST)
In-Reply-To: <20110113171249.GH30351@opensource.wolfsonmicro.com>
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
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 13, 2011 at 12:12, Mark Brown wrote:
> On Thu, Jan 13, 2011 at 11:52:02AM -0500, Mike Frysinger wrote:
>> On Thu, Jan 13, 2011 at 08:55, Mark Brown wrote:
>> > Ccing in Liam - Mike, please remember to CC maintainers on patches - and
>> > dropping the stable lists for now.
>>
>> i thought you were the ASoC maintainer
>
> We comaintain ASoC, we generally both review everything except during
> vacations.

np ... i'll update my .git/mail
-mike
