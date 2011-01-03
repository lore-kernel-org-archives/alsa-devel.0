From: Seungwhan Youn <claude.youn@gmail.com>
Subject: Re: [PATCH] ASoC: Change Samsung Kconfig from ASOC_ to
	SND_SOC_
Date: Mon, 3 Jan 2011 10:43:53 +0900
Message-ID: <AANLkTimw6ywAWvzmfZqsMzUqoosKdwYDx3ezKPOGLM+G@mail.gmail.com>
References: <1293977528-6141-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 1C4BD24772
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2011 02:43:54 +0100 (CET)
Received: by wyi11 with SMTP id 11so12777492wyi.38
	for <alsa-devel@alsa-project.org>; Sun, 02 Jan 2011 17:43:53 -0800 (PST)
In-Reply-To: <1293977528-6141-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, Seungwhan Youn <sw.youn@samsung.com>, patches@opensource.wolfsonmicro.com, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 2, 2011 at 11:12 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> The rest of ASoC is using SND_SOC_ as the prefix for all the Kconfig
> symbols so do so for the new Samsung drivers too, rather than using
> ASOC_ as they currently are.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I'll prepare to remake(and resubmit) patch-set, "Modify configures to
support Samsung ASoC dependancyless", that I submitted before. :)

Acked-by: Seungwhan Youn <sw.youn@samsung.com>

Thanks,
Claude
