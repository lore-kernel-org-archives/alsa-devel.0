From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 11/11] ASoC: pxa-ssp: Handle return value of clk_prepare_enable.
Date: Fri, 11 Aug 2017 21:08:53 +0200
Message-ID: <87wp69oray.fsf@belgarion.home>
References: <1500977770-28142-1-git-send-email-arvind.yadav.cs@gmail.com>
        <1500977770-28142-2-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, krzk@kernel.org, sbkim73@samsung.com, daniel@zonque.org, haojian.zhuang@gmail.com, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Arvind Yadav <arvind.yadav.cs@gmail.com> writes:

> clk_prepare_enable() can fail here and we must check its return value.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
