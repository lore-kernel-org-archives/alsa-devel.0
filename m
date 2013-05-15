From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH] ASoC: remove saarb and tavorevb3 machine drivers
Date: Wed, 15 May 2013 09:58:30 +0800
Message-ID: <CAN1soZyUQRvDWcmefS3SnN=92rOp1LVknHFKzwqO6q88__ULMw@mail.gmail.com>
References: <1368544041.1350.111.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368544041.1350.111.camel@x61.thuisdomein>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, May 14, 2013 at 11:07 PM, Paul Bolle <pebolle@tiscali.nl> wrote:
> Support for PXA95x was removed in v3.8. This means that the Kconfig
> symbols MACH_SAARB and MACH_TAVOREVB3 are no longer available. This
> leaves the SoC Audio support for Marvell Saarb and Marvell Tavor EVB3
> unbuildable. Remove these drivers too.
>
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
