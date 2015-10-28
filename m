From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/3] gpio: arizona: Support Cirrus Logic CS47L24 and
 WM1831
Date: Wed, 28 Oct 2015 11:42:05 +0000
Message-ID: <20151028114205.GU5828@x1>
References: <1445264027-7357-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1445264027-7357-3-git-send-email-rf@opensource.wolfsonmicro.com>
 <CACRpkdZMsUbhvKiAEcKuEy7OCGLYG9Up_AUJcfThbVcMdPeLPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZMsUbhvKiAEcKuEy7OCGLYG9Up_AUJcfThbVcMdPeLPg@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, "open list:WOLFSON MICROELECTRONICS DRIVERS" <patches@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 27 Oct 2015, Linus Walleij wrote:

> On Mon, Oct 19, 2015 at 4:13 PM, Richard Fitzgerald
> <rf@opensource.wolfsonmicro.com> wrote:
>=20
> > The CS47L24 and WM1831 codecs only have two GPIO lines, but are
> > otherwise similar to the WM8280.
> >
> > Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
>=20
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> Lee can merge this into the MFD tree with patch 1/3 if he likes,
> I guess that's simplest.

I can do.  Do you require a pull-request?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
