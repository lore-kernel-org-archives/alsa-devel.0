From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/3] mfd: mc13xxx: Move SPI erratum workaround into SPI
 I/O function
Date: Wed, 25 Sep 2013 14:05:14 +0100
Message-ID: <20130925130514.GK5132@lee--X1>
References: <1379960073-23245-1-git-send-email-broonie@kernel.org>
 <1379960073-23245-2-git-send-email-broonie@kernel.org>
 <20130925111954.GG5132@lee--X1>
 <20130925113103.GN3226@sirena.org.uk>
 <20130925114643.GH5132@lee--X1>
 <20130925115502.GI5132@lee--X1>
 <20130925123536.GO3226@sirena.org.uk>
 <20130925125139.GJ5132@lee--X1>
 <20130925125538.GP3226@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20130925125538.GP3226@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org
List-Id: alsa-devel@alsa-project.org

On Wed, 25 Sep 2013, Mark Brown wrote:

> On Wed, Sep 25, 2013 at 01:51:39PM +0100, Lee Jones wrote:
> > On Wed, 25 Sep 2013, Mark Brown wrote:
> > > On Wed, Sep 25, 2013 at 12:55:02PM +0100, Lee Jones wrote:
>=20
> > > > https://git.linaro.org/gitweb?p=3Dpeople/ljones/mfd.git mfd-aso=
c
>=20
> > > Thanks, could you include the first patch as well please (there's=
 a
> > > dependency for bisection due to the BUG_ONs)?=20
>=20
> > Okay, done. Same branch.
>=20
> Pulled, thanks.  That URI isn't directly pullable BTW.

I know.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
