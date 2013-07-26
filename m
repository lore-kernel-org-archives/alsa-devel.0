From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH 4/4] ASoc: kirkwood: add DT support
Date: Fri, 26 Jul 2013 11:49:46 +0200
Message-ID: <20130726114946.1945bc1a@armhf>
References: <20130725111459.145a4aa4@armhf>
	<20130725191905.GR9858@sirena.org.uk>
	<20130725230533.GH24642@n2100.arm.linux.org.uk>
	<20130726110913.0a193918@armhf>
	<20130726092156.GK24642@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130726092156.GK24642@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Fri, 26 Jul 2013 10:21:56 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Fri, Jul 26, 2013 at 11:09:13AM +0200, Jean-Francois Moine wrote:
> > The A510 documentation uses the names "DCO PLL" for the internal cl=
ock
> > and "AU_EXTCLK" for the external clock. So, what about "dcopll" and
> > "extclk"?
>=20
> Stop naming them according to their source.  Their _consumer_ names
> not _source_ names.

I have no preference. What do you propose?

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
