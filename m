From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC CS4270 codec device driver
Date: Mon, 30 Jul 2007 15:26:34 -0500
Message-ID: <46AE497A.40005@freescale.com>
References: <11858194924152-git-send-email-timur@freescale.com>
	<s5h4pjl3bmm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 0802424522
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Jul 2007 22:26:37 +0200 (CEST)
In-Reply-To: <s5h4pjl3bmm.wl%tiwai@suse.de>
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

> The patch looks OK at a brief glance, but it seems to have tiny
> coding-style issues in some places.  Try to run scripts/checkpatch.pl
> in the linux kernel.

Is checkpatch.pl new?  I've never seen it before.  It's very nice, though.

I have submitted a new patch that verifies with checkpatch.pl.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
