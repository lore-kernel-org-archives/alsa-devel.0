From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v4 2/3] ARM: mx28evk: add platform data for
	saif
Date: Fri, 11 Nov 2011 14:06:33 +0800
Message-ID: <20111111060632.GB8732@S2100-06.ap.freescale.net>
References: <1320907333-12696-1-git-send-email-b29396@freescale.com>
	<1320907333-12696-3-git-send-email-b29396@freescale.com>
	<20111110083852.GU16886@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 66C842439F
	for <alsa-devel@alsa-project.org>; Fri, 11 Nov 2011 06:54:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20111110083852.GU16886@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, w.sang@pengutronix.de, u.kleine-koenig@pengutronix.de, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 10, 2011 at 09:38:52AM +0100, Sascha Hauer wrote:
[...]
> This function pointers are not devicetree friendly. I don't know whether
> i.MX28 will be ever converted to devicetree,

It will.  This is something on my TODO list.

Regards,
Shawn

> but we should not
> unnecessary additional hurdles.
> 
