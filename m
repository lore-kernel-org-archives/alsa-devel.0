From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH v5 0/4] ASoC: mxs: add audio support
Date: Thu, 28 Jul 2011 05:56:04 +0000
Message-ID: <65EE16ACC360FA4D99C96DC085B3F7721EF253@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1311223018-9553-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 810B3103810
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Jul 2011 07:56:09 +0200 (CEST)
In-Reply-To: <1311223018-9553-1-git-send-email-b29396@freescale.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
Cc: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "lrg@ti.com" <lrg@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-arm-
> kernel-bounces@lists.infradead.org] On Behalf Of Dong Aisheng
> Sent: Thursday, July 21, 2011 12:37 PM
> To: alsa-devel@alsa-project.org
> Cc: s.hauer@pengutronix.de; broonie@opensource.wolfsonmicro.com;
> lrg@ti.com; linux-arm-kernel@lists.infradead.org; w.sang@pengutronix.de
> Subject: [PATCH v5 0/4] ASoC: mxs: add audio support
> 
> According to Liam's comment, i redo the patch set based on the for-next
> branch on Mark's sound-2.6 tree.
> The based one is [PATCH v4 00/10] ARM: mxs: add audio support.
> 
> For asoc part (1-4), only one change is updating mxs_pcm_new since this
> API has been updated to pass in the runtime data only For mxs part, no
> changes made.
> 

Hi Mark,

Do you have any comment on this new patch series?

Regards
Dong Aisheng
