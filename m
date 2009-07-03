From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH] ASoC: TWL4030: Add tristate callbacks for
	HiFi and Voice
Date: Fri, 3 Jul 2009 11:58:20 +0300
Message-ID: <200907031158.20630.peter.ujfalusi@nokia.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E39685562@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 34B921038AD
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jul 2009 10:58:26 +0200 (CEST)
In-Reply-To: <67059DBF19D7214F9C66BB0EA91BA90E39685562@dlee04.ent.ti.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "ext Lopez Cruz,
	Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Friday 03 July 2009 10:21:39 ext Lopez Cruz, Misael wrote:
> Add "set_tristate" callbacks for HiFi and Voice DAIs.
> Machine drivers can enable and disable tristate for each
> DAI with "snd_soc_dai_set_tristate" function.
>
> Signed-off-by: Misael Lopez Cruz <x0052729@ti.com>

Thank you,

Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
