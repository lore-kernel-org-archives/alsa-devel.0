From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 00/10] ASoC: ARM: ux500: Better prepare for full Device Tree
Date: Tue, 7 Jan 2014 15:06:22 +0100
Message-ID: <CACRpkdYWbPH+MfYPen=phGL0Oik44+HaYjyqCP78YpMrRG6QYw@mail.gmail.com>
References: <1387468508-12286-1-git-send-email-lee.jones@linaro.org>
	<20131221142959.GH30815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131221142959.GH30815@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 21, 2013 at 3:29 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Dec 19, 2013 at 03:54:57PM +0000, Lee Jones wrote:
>> At this moment in time the Ux500 ASoC driver obtains its DMA information
>> via AUXDATA platform data passing. To make the driver more independent
>> we have to start extracting it from the Device Tree. This patch-set goes
>> some way to ensure the ux500 Audio driver is ready for the switch over.
>
> This all looks good to me, I guess it's OK if I merge the ARM patch?

Yes I ACKed it now.

Sorry for slow response & thanks Mark.

Yours,
Linus Walleij
