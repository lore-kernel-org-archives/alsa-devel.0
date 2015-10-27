From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 2/3] gpio: arizona: Support Cirrus Logic CS47L24 and WM1831
Date: Tue, 27 Oct 2015 10:58:44 +0100
Message-ID: <CACRpkdZMsUbhvKiAEcKuEy7OCGLYG9Up_AUJcfThbVcMdPeLPg@mail.gmail.com>
References: <1445264027-7357-1-git-send-email-rf@opensource.wolfsonmicro.com>
	<1445264027-7357-3-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1445264027-7357-3-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 19, 2015 at 4:13 PM, Richard Fitzgerald
<rf@opensource.wolfsonmicro.com> wrote:

> The CS47L24 and WM1831 codecs only have two GPIO lines, but are
> otherwise similar to the WM8280.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Lee can merge this into the MFD tree with patch 1/3 if he likes,
I guess that's simplest.

Yours,
Linus Walleij
