From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: add GPIO IRQ support
Date: Wed, 22 Oct 2014 11:44:07 +0100
Message-ID: <20141022104407.GO2344@sirena.org.uk>
References: <1413483866-38815-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5848807459163803916=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D38F4264FBA
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 12:44:17 +0200 (CEST)
In-Reply-To: <1413483866-38815-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5848807459163803916==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1bhFRg6vL9BT9osV"
Content-Disposition: inline


--1bhFRg6vL9BT9osV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2014 at 11:24:26AM -0700, Anatol Pomozov wrote:
> This allows to enable Mic Jack detection feature

Applied, thanks. =20

> Author: Oder Chiou <oder_chiou@realtek.com>
> Modified-by: Anatol Pomozov <anatol.pomozov@gmail.com>
> Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>

The standard way to do this sort of stuff unless it's a total rewrite is
to leave the patch author intact in the commit and put a note in the
commit log about the modifications.

--1bhFRg6vL9BT9osV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR4p2AAoJECTWi3JdVIfQgmsH+QF/U7yfwzUfzL/7MNy0uz67
Bm1u3jLQCaAS/K6scEb4O8s306oKhKC0x5MCE8CJqrokJbALEDj5Vo4xAH9gxYUm
MezuK+WVWn/UBgeMZmxzZkQHgHCt+f6WZs44Y6AmNBfQ4hFe5auXirxTjjRNgMBg
bPMCdlOV7l/1kMRomiBCF8jvNGRuySLTLZ4lgKua2bXa7K6hFnZyKJ9x2hv7Nw2L
PqyILj2DLfVLM7LPFB9rSn/iJ+h+mXcAVlKqEAelinHbv6rpbmtCDmqinB3CxhS7
h2+HFqZjDH95fJt3j9mzKhrrU1q8pvKaec277LgYxXECDBPZr/QQD92FNAFFDHo=
=a6JG
-----END PGP SIGNATURE-----

--1bhFRg6vL9BT9osV--

--===============5848807459163803916==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5848807459163803916==--
