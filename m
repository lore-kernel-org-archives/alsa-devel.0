From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: tpa6130a2: Define output pins with
 SND_SOC_DAPM_OUTPUT
Date: Wed, 19 May 2010 16:39:21 +0100
Message-ID: <1274283561.3240.170.camel@odin>
References: <1274266526-29439-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E3323103960
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 17:39:27 +0200 (CEST)
Received: by fxm18 with SMTP id 18so2323574fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 19 May 2010 08:39:27 -0700 (PDT)
In-Reply-To: <1274266526-29439-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-05-19 at 13:55 +0300, Jarkko Nikula wrote:
> Codec output pin should be defined with SND_SOC_DAPM_OUTPUT as otherwise
> external widgets doesn't alter the output state.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> ---
Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
