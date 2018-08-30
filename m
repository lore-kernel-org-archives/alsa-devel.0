From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/15][RFC] ASoC: use
 snd_soc_dai_link_component style for simple card
Date: Thu, 30 Aug 2018 15:12:13 +0100
Message-ID: <20180830141213.GC7301@sirena.org.uk>
References: <878t51vdd3.wl-kuninori.morimoto.gx@renesas.com>
 <87h8jojk6m.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8422525568244170671=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 76074267668
 for <alsa-devel@alsa-project.org>; Thu, 30 Aug 2018 16:12:15 +0200 (CEST)
In-Reply-To: <87h8jojk6m.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============8422525568244170671==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 21, 2018 at 06:47:48AM +0000, Kuninori Morimoto wrote:

> Please let me know if v1 looks OK,
> then, I will post v2 patch.

This looks like it moves everything in a more consistent direction so I
think it should be fine.

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluH+zwACgkQJNaLcl1U
h9BaKQf9HxPaEtx8tqVXigDw4nITMZ0tTI3Q7tP4d/sPMLZkPt9L/BDab7mG5b/h
klZx4S/X6xj8XA+qugTtYbYkfSXXn0bMREH3RhUWmZeooFWo4swadn6H7S/gQFrN
Tb6lRL/A9JuspVQLzyhCFXb432uxo4X/6BdJ5srX2iICKUFwRFpd+yimzOzwaNX+
5+zAPsaI1tlNLat27HRNv9nZ/SvUZQ7+TkbRldkKfsfGJrPxL7KzwEPM5Ax0afLF
darT5eSfcnwFJoSzgHm97zkpGxfW7fZxtpKBfBrWuWBNB+RjBlqUY4CqPgQhGsc0
Zp+pS730PY6YPrd43llTvC6NudBHGQ==
=To7e
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--

--===============8422525568244170671==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8422525568244170671==--
