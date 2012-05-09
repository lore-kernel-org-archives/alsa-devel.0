From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l52: Staticise non-exported
	symbols
Date: Wed, 9 May 2012 16:39:24 -0500
Message-ID: <alpine.DEB.2.02.1205091638071.6547@heelrod.ad.cirrus.com>
References: <1336598160-4798-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 68850103F9E
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 23:42:16 +0200 (CEST)
In-Reply-To: <1336598160-4798-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Makes sparse happy and avoids polluting the global namespace.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
Acked-by: Brian Austin <brian.austin@cirrus.com>
