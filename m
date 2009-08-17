From: =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozan@pardus.org.tr>
Subject: Re: How to use hda-verb to detect
Date: Mon, 17 Aug 2009 17:01:31 +0300
Message-ID: <4A8962BB.2050202@pardus.org.tr>
References: <4A89219E.20400@pardus.org.tr>	<s5hljlieqcn.wl%tiwai@suse.de>	<4A8925D3.2000203@pardus.org.tr>	<s5hfxbqeplg.wl%tiwai@suse.de>	<4A894E4A.6060801@pardus.org.tr>
	<s5hhbw64kvp.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lider.pardus.org.tr (lider.pardus.org.tr [193.140.100.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 028A42472E
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Aug 2009 15:57:58 +0200 (CEST)
In-Reply-To: <s5hhbw64kvp.wl%tiwai@suse.de>
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

Takashi Iwai wrote On 17-08-2009 16:42:
>
> It means that 0x0a corresponds to one HP.
> And, with this situation, do both HPs work (and also auto-muting)?
>   
Yes both HP and auto-muting works (they always behaved exactly the same
for every model I've tried) but 'Speaker' is gone so 'Front ' started to
control both HPs and also internal speaker which is bad.
