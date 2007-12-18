From: Timur Tabi <timur@freescale.com>
Subject: Re: rate plugin issue
Date: Tue, 18 Dec 2007 09:43:38 -0600
Message-ID: <4767EAAA.5000708@freescale.com>
References: <s5hwssnx58j.wl%tiwai@suse.de>
	<4738A89D.9060601@aknet.ru>	<s5hmytihlvo.wl%tiwai@suse.de>
	<473B561A.1050203@aknet.ru>	<s5h6404dmsi.wl%tiwai@suse.de>
	<473F01E9.8070907@aknet.ru>	<s5hir3ylce1.wl%tiwai@suse.de>
	<4741FB78.8040302@aknet.ru> <s5habp9bf7s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id BC7402454E
	for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2007 19:23:45 +0100 (CET)
In-Reply-To: <s5habp9bf7s.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Stas Sergeev <stsp@aknet.ru>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Sorry, no, it's just because I've been busy for other things.
> Will be applied today soon.

So is this patch supposed to fix the OSS sample-rate conversion plug-in?  Has 
this patch been pushed to kernel.org yet? I had to disable 
CONFIG_SND_PCM_OSS_PLUGINS because it was causing underruns.

-- 
Timur Tabi
Linux kernel developer at Freescale
