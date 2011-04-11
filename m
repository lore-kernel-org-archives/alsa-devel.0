From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Add initial WM1250-EV1 Springbank
 audio I/O module driver
Date: Mon, 11 Apr 2011 20:59:50 +0100
Message-ID: <1302551990.3449.63.camel@odin>
References: <1302499000-24376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B91B71038F4
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 21:59:54 +0200 (CEST)
Received: by wyg36 with SMTP id 36so5579217wyg.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2011 12:59:54 -0700 (PDT)
In-Reply-To: <1302499000-24376-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Sun, 2011-04-10 at 22:16 -0700, Mark Brown wrote:
> The WM1250-EV1 Springbank audio I/O module for the Wolfson Glenfarclas
> reference platform provides a simple audio I/O with an independant clock
> domain, intended to simulate cellular modem and bluetooth subsystems
> within the platform.
> 
> The card supports some limited GPIO based control but this is currently not
> implemented.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>
