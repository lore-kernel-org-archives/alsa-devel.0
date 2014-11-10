From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] ASoC: davinci-mcasp: Symmetric sample
 bits for IIS mode
Date: Mon, 10 Nov 2014 14:55:33 +0000
Message-ID: <20141110145533.GV3815@sirena.org.uk>
References: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
 <1415615540-28981-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2448124721786966085=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1021A261A3B
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 15:56:51 +0100 (CET)
In-Reply-To: <1415615540-28981-5-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2448124721786966085==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EAxp3f1s+pEXSACT"
Content-Disposition: inline


--EAxp3f1s+pEXSACT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 12:32:18PM +0200, Peter Ujfalusi wrote:
> In IIS mode the tx and rx configuration is symmetric, the BCLK and FSYNC is
> shared.

Applied, thanks.

--EAxp3f1s+pEXSACT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYNHlAAoJECTWi3JdVIfQpawIAIREGUPT0opFJnAn/dJZwXR8
ZGMxG//zBvbDd4u2dgizmQJjOXOCl3D9zJAL592wJH1m6EAcyvXxrJGaCOPwiMZI
7X/BSBR+C3CBxHHRzhQ7BJSwJdCSf3rR0m53UIbLsasMxYZUxVttPC/NEl7yV/ie
+/5Swcgxx9JF2sBYNZakt2F3Qt+6G8Iw2S8+euSRymeRv/o7KeyQXRhCgc0On/1G
y6GsrQVJrADUnFtz1qShpmti8QK6HI5eEWOBIS3pombkn7ykTTKrZoLIcx2qdIUF
8glKGJOKDKdapGZ4H4oaseFWUN4j40r9Ft4ZQ43p3bnqJxp53eSSKVgK5akhOPo=
=F7GB
-----END PGP SIGNATURE-----

--EAxp3f1s+pEXSACT--

--===============2448124721786966085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2448124721786966085==--
