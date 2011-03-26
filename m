From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/7] ASoC: Add control_type in snd_soc_codec
Date: Sat, 26 Mar 2011 12:59:52 +0000
Message-ID: <4D8DE348.2070902@ti.com>
References: <1300790223-13308-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 53D4F24368
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 14:00:00 +0100 (CET)
In-Reply-To: <1300790223-13308-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 22/03/11 10:36, Dimitris Papastamos wrote:
> This is mainly used by the soc-cache code to easily determine the
> currently used underlying serial bus.  Set SND_SOC_CUSTOM to 1 so we
> can distinguish it if it is not initialized or set.
> 
> Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>

All

Acked-by: Liam Girdwood <lrg@ti.com>
