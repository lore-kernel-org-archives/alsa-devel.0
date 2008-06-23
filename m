From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Fix register programming in Freescale
 MPC8610 HPCD sound driver
Date: Mon, 23 Jun 2008 11:48:07 -0500
Message-ID: <485FD3C7.6010301@freescale.com>
References: <1213383751-17284-1-git-send-email-timur@freescale.com>	<485FD229.1090102@freescale.com>
	<s5hej6o3xqs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id D4062103890
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jun 2008 18:48:21 +0200 (CEST)
In-Reply-To: <s5hej6o3xqs.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> No, it's not pushed for 2.6.26 although it's already on my tree for
> the next kernel release.  If this is an urgent fix for 2.6.26, please
> show it explicitly.  Otherwise I won't do it always (especially
> changes for ASoC that I cannot test by myself)...

I wouldn't say it's urgent.

-- 
Timur Tabi
Linux kernel developer at Freescale
