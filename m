From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH][ASoC v2] Replace snd_soc_free_codec with
 snd_soc_unregister_codec
Date: Thu, 24 Apr 2008 11:37:40 -0500
Message-ID: <4810B754.9030308@freescale.com>
References: <1209054001-1155-1-git-send-email-timur@freescale.com>	<s5hmynjb4cu.wl%tiwai@suse.de>	<4810B661.2040308@freescale.com>
	<s5hlk33b49a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 2976224591
	for <alsa-devel@alsa-project.org>;
	Thu, 24 Apr 2008 18:37:44 +0200 (CEST)
In-Reply-To: <s5hlk33b49a.wl%tiwai@suse.de>
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

> At least, a compile test before submitting the patch would be
> appreciated ;)

I can't compile ASoC V2 code because it breaks on my system, and I don't have an
ARM cross-compiler.

-- 
Timur Tabi
Linux kernel developer at Freescale
