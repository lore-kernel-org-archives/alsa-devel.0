From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Define output pins with
 SND_SOC_DAPM_OUTPUT
Date: Wed, 19 May 2010 07:56:31 -0700
Message-ID: <1274280991.2698.1035.camel@finisterre.wolfsonmicro.main>
References: <1274266526-29439-1-git-send-email-jhnikula@gmail.com>
	(sfid-20100519_115536_332265_588BA5D5)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 61EE61038FA
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 16:56:22 +0200 (CEST)
In-Reply-To: <1274266526-29439-1-git-send-email-jhnikula@gmail.com>
	(sfid-20100519_115536_332265_588BA5D5)
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
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-05-19 at 13:55 +0300, Jarkko Nikula wrote:
> Codec output pin should be defined with SND_SOC_DAPM_OUTPUT as otherwise
> external widgets doesn't alter the output state.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
