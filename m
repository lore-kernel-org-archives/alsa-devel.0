From: Enrico Mioso <mrkiko.rs@gmail.com>
Subject: Re: Intel HDA audio on EEE PC 1101HGo
Date: Tue, 22 Nov 2016 17:41:11 +0100 (CET)
Message-ID: <alpine.LNX.2.20.1611221739110.1886@localhost.localdomain>
References: <alpine.LNX.2.20.1504082130290.1715@localhost.localdomain>
 <s5hegntl2cs.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1504111011090.1174@localhost.localdomain>
 <s5hvbh13mxe.wl-tiwai@suse.de>
 <alpine.LNX.2.20.1611221406590.1908@localhost.localdomain>
 <046CEDB3-19C3-406A-B094-6665E5FBC32B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id CF573266D22
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 17:41:17 +0100 (CET)
Received: by mail-wm0-f68.google.com with SMTP id m203so4996439wma.3
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 08:41:17 -0800 (PST)
In-Reply-To: <046CEDB3-19C3-406A-B094-6665E5FBC32B@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mrkiko Rs <mrkiko.rs@gmail.com>
Cc: alsa-devel@alsa-project.org, kailang@realtek.com, Takashi Iwai <tiwai@suse.de>, hui.wang@canonical.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

Hello.
Now I am trying setting single_cmd to 1, lots of things overflow my logs as advertised, including this interesting message any time I cause a beep on the terminal:
snd_hda_intel 0000:00:1b.0: spurious response 0x0:0x0, last cmd=0x170a00

I know lots more infos would be needed... consider this just the result of a curious guy. Right now I don't know if I'll be ever able to work "well" on this system, regarding fixing those problems.
Tank you for all,
Enrico
