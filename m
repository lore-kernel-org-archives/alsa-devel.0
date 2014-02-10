From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/8] ASoC: da9055: Fix device registration of PMIC and
 CODEC devices
Date: Mon, 10 Feb 2014 14:42:34 +0000
Message-ID: <20140210144234.GB26697@lee--X1>
References: <cover.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
 <6a398d176b0b2bf8792d27bd5e2995fd96afb32d.1391705989.git.Adam.Thomson.Opensource@diasemi.com>
 <20140210134310.GH1757@sirena.org.uk>
 <20140210135939.GA23141@lee--X1>
 <20140210141400.GJ1757@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140210141400.GJ1757@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org

> > > Applied, thanks.
>=20
> > Actually, do you mind if I take this and apply it to an immutable?
>=20
> > I'd rather not be on the wrong end of some wrath, due to not playin=
g
> > the game properly.
>=20
> OK, but it does need to go in as a fix targetted for stable.

Ah, in which case there's no need, as I don't have anything in my
-fixes branch with touches this file. Simply take it in, no problem.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
