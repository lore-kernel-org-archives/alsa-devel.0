From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC updates for v3.16
Date: Tue, 17 Jun 2014 16:04:57 +0100
Message-ID: <20140617150457.GB5099@sirena.org.uk>
References: <20140617110725.GM5099@sirena.org.uk>
 <s5hppi7da9y.wl%tiwai@suse.de>
 <20140617145426.GA5099@sirena.org.uk>
 <s5h1tund1nm.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5633440760510325460=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 22B70265620
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 17:05:14 +0200 (CEST)
In-Reply-To: <s5h1tund1nm.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5633440760510325460==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r/ZtdXyXOm4f7aFt"
Content-Disposition: inline


--r/ZtdXyXOm4f7aFt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 17, 2014 at 04:57:33PM +0200, Takashi Iwai wrote:

> OK, if you've already applied on top of it, I don't mind to pull as
> is.  Although it doesn't look good, it's easy enough to judge that
> it's a simple git am error.  I just hoped that it were still the top
> most on the branch and easy to rebase.

It's easy to replace that one branch (I did an update already) but the
thing I send to you is an automatic merge of that and all my other fixes
branches and there's some new fixes branches, I'll either need to redo
everything by hand or wait for at least tomorrow.

--r/ZtdXyXOm4f7aFt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJToFkWAAoJELSic+t+oim9vgcQAIxF2khtPz/aaBhirZcqWGU/
nZ4HVtLYq1szEKqeucpF25DnzoDzQhSvZncKVB6OJwc7WP38OGbCOdkP+dZi3i7M
Br3W5+Fwd/I9qXgGoRHRQ2fmfp11UQsndZKE1qGAWR2zaeOQaozhTje0lTyK/ESh
+bj5xAT3oO3A50fe48GdXJEMlAeqHQNfIrlfZNo6yzik/DKWqwLIIWn9dhqhuMlO
tZXX5widZ0RWH7T1tETi3ajwwu6mdBXHBYSl8CCgZKLEdtnAg4jXlo3zfhk8mXm1
X+8fg0e1KYiB+zwmB06b1WJZor5xjzJYNuCU5LKxtxi45aVCVyGIGFi2hGJUF/XE
2coO0AcONvIVSx6rfQ0ow47qpfy67JdO+PdmwNEYajUW4fE6NBZWUYsYXYdZC+/2
z7/8sxmo6vndHW3EI1NIuf6nB1Db11Fp//UlMbpkAAMMiJqnIrrhPIrq3iQ1mbvp
pwdryxl6wBZouX9CpKD0p/4IwxoV73AYO/EFm5HSSdVYz2IVj3LwmBWjpZgnOdK5
IhyT2+0qddwnSH9BpCJ+3/LVdMxdX9BCk1We8GJ106GN2QzO3eIciZ3K5ncUMLmX
c7Cexz3hkfjIGk7MHFLJJ5BMLaqu8qBchGwupDPE0V1yZEj6oAp3aGcttmIlQS10
yRGNRLYVbpa92FjdB32W
=OE2+
-----END PGP SIGNATURE-----

--r/ZtdXyXOm4f7aFt--

--===============5633440760510325460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5633440760510325460==--
