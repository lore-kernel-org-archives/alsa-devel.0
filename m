From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: gtm601: Remove .owner field from
 platform driver
Date: Wed, 24 Jun 2015 12:50:48 +0100
Message-ID: <20150624115048.GJ14071@sirena.org.uk>
References: <1435114524.2082.1.camel@ingics.com>
 <1435114591.2082.2.camel@ingics.com>
 <20150624102354.GG14071@sirena.org.uk>
 <CAFRkauCFqyBVi2FqS2mqbM6kbyO91UULFDtx5UsCn+vai7o-eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7884374110100834678=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B28B260566
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 13:51:00 +0200 (CEST)
In-Reply-To: <CAFRkauCFqyBVi2FqS2mqbM6kbyO91UULFDtx5UsCn+vai7o-eg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Marek Belisko <marek@goldelico.com>, Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============7884374110100834678==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BJP9N0ZakeEJ79cG"
Content-Disposition: inline


--BJP9N0ZakeEJ79cG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2015 at 07:46:49PM +0800, Axel Lin wrote:
> 2015-06-24 18:23 GMT+08:00 Mark Brown <broonie@kernel.org>:

> > This doesn't apply against current code, please check and resend.

> It's fixed by kbuild test robot <fengguang.wu@intel.com> in topic/gtm601.

The main bit is but it looked like you had some other changes which are
probably still worthwhile?

--BJP9N0ZakeEJ79cG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVipmXAAoJECTWi3JdVIfQWIMH/0XWmlXDxBNXcNkaj4oTSiCN
l/KGZ5RkKehAvdiUEv/iSy6ofM+pSAUc57v1Cgu0YDXxGaiGrd8pWFZt+rB2iZsD
GRzW1avUkhvizU9bwjfzf01i7At6CfM83kVAEzRRuAFz5fT9JpePeIZaHlniACjn
VHBA6ik06HJVR0q5s41zRo9AxAAPJxdvUbEpn/abTJiK27PCzfSHJMU3WvWzTrCw
l5Qj9NwGbIW7FXb6DrN5spVq+CGQK34KALE1XDZWJ3OdToaXuw0B7+c6GOXYuUwH
4l0cu5A5/CpAKK2Che6E6nNsuTN4nmBXgkfAmkqGMlQVcZ1KqzY3xQ0Svs87i0U=
=RyKb
-----END PGP SIGNATURE-----

--BJP9N0ZakeEJ79cG--

--===============7884374110100834678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7884374110100834678==--
