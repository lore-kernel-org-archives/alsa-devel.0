From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC fix for v5.2
Date: Wed, 8 May 2019 19:31:50 +0900
Message-ID: <20190508103150.GP14916@sirena.org.uk>
References: <20190508094554.GK14916@sirena.org.uk>
 <s5h4l65s0kr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8219550671014921984=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DB245F80796
 for <alsa-devel@Alsa-project.org>; Wed,  8 May 2019 12:32:02 +0200 (CEST)
In-Reply-To: <s5h4l65s0kr.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@Alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8219550671014921984==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q2l42ZpTeLjzDHJr"
Content-Disposition: inline


--Q2l42ZpTeLjzDHJr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 12:27:32PM +0200, Takashi Iwai wrote:
> On Wed, 08 May 2019 11:45:54 +0200,
> Mark Brown wrote:

> > Emil Renner Berthing (1):
> >       spi: rockchip: turn down tx dma bursts

> BTW, is this commit intended to be in sound git repo?
> Or was it applied to a wrong branch?  Just for confirmation...

No, that's a mistake :/

--Q2l42ZpTeLjzDHJr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSsBUACgkQJNaLcl1U
h9A7IQf/ZOwYLcPp4MChO4RmQcqiQgWQMT/yO1HGijjWYHWWEVWi87kKXKWmXAWO
s9sPpTQUwf0P8A0pLwej2raGZvNS1qUOAxHVNfaW6dnYU2SDaaEaRMOOl9LPmnKn
bkx5nO/A7aIMxGUEy7CPW6+LzNbYHYG/HHG7eAXklhOJu1jriNa5PxFxzyaxmMR2
QYfz0SalwsCWifjLKzcDjWiXaAlSFfspJnsOzgg/T0GpBJvXx9UfpS0tGCWzKabO
EWlYftKsUS2jA8uIZ4zc4sjU6co/qrXasMPdOv96ySTjc+2wI7/XL1k7b7xCG3LA
s9V29X8ELjggUJlcUagbg4KkaGPitg==
=zueD
-----END PGP SIGNATURE-----

--Q2l42ZpTeLjzDHJr--

--===============8219550671014921984==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8219550671014921984==--
