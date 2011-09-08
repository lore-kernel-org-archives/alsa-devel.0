From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH v2] ASoC: omap: add MODULE_ALIAS to mcbsp
 and pcm drivers
Date: Thu, 08 Sep 2011 08:50:55 +0300
Message-ID: <4E6857BF.9010904@bitmer.com>
References: <1315393641-21261-1-git-send-email-mans.rullgard@linaro.org>
	<20110907171049.GA2906@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bitmer.com (bitmer.com [213.157.87.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 0D8E6245ED
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 07:51:07 +0200 (CEST)
In-Reply-To: <20110907171049.GA2906@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, linaro-dev@lists.linaro.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, linux-omap@vger.kernel.org, Mans Rullgard <mans.rullgard@linaro.org>
List-Id: alsa-devel@alsa-project.org

On 09/07/2011 08:10 PM, Mark Brown wrote:
> On Wed, Sep 07, 2011 at 12:07:21PM +0100, Mans Rullgard wrote:
>> This adds MODULE_ALIAS directives to the omap-mcbsp-dai and
>> omap-pcm-audio drivers so they can be auto-loaded when platform
>> devices are scanned.
>
> Acked-by: Mark Brown<broonie@opensource.wolfsonmicro.com>

Now looks good.

Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
