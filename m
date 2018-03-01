From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: max9867: Drop probe function
Date: Thu, 1 Mar 2018 21:37:41 +0000
Message-ID: <20180301213741.GX12864@sirena.org.uk>
References: <20180301141843.GB30722@lenoch> <20180301142027.GE30722@lenoch>
 <20180301175654.GF12864@sirena.org.uk>
 <20180301200618.GB2304@lenoch>
 <20180301203903.GO12864@sirena.org.uk>
 <20180301213242.GA3833@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0508847672974752282=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DFFD267C5D
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 22:37:42 +0100 (CET)
In-Reply-To: <20180301213242.GA3833@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: alsa-devel@alsa-project.org


--===============0508847672974752282==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e9ndEBTQFD7P4kUb"
Content-Disposition: inline


--e9ndEBTQFD7P4kUb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 01, 2018 at 10:32:43PM +0100, Ladislav Michl wrote:
> On Thu, Mar 01, 2018 at 08:39:03PM +0000, Mark Brown wrote:
> > On Thu, Mar 01, 2018 at 09:06:18PM +0100, Ladislav Michl wrote:
> > > On Thu, Mar 01, 2018 at 05:56:54PM +0000, Mark Brown wrote:

> > > > This doesn't apply against current code, please check and resend.

> > > It was generated and tested against next-20180301. Which version do
> > > you want me to generate against? Based on 4.16-rc1 it'll fail to
> > > merge later.

> > That is my current tree but I don't have a topic for this device other
> > than your patches...  please resend and I'll take a look what git didn't
> > like.

> Well, in fact you have, but it is misnamed as topic/wm9867. So I guess
> once you merge these two topic branches, things will get fixed.

Sorry, meant to reply here: as I said above, please resend.

--e9ndEBTQFD7P4kUb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqYcqQACgkQJNaLcl1U
h9DSjgf/U4F8Od9pqCixtJgZNFwjee1DCrKSka1MHkHdIFKl402olKwKGZYYP0hS
3adBGPOtk3VeY3mMEbGgComg12sbno1yGupWgA1UolCeB13Yy++XHtXOPn3276y0
BX6YL+WvGSQE71gdxGWHuRYjizIPo4iqPj0RJUhForyjWAqDgk5jFMtqZV0oy1ee
S6IdTHW6RiIsniWU2uJB/66Vi0XGhxpElijChPhnmBsZLLeVAwnRprZF6xDWsKMi
hyqge59AciKH+1/Mnh/XavyoUbCkSnkC/JmtEuXDE47JLg69colxhEXzS2fJ/7+h
PqHgON76OOUZZUNQtPfiA9KRDhbTMQ==
=Kp+q
-----END PGP SIGNATURE-----

--e9ndEBTQFD7P4kUb--

--===============0508847672974752282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0508847672974752282==--
