From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: bcm2835: Add 8 channel
	(multitrack) capability
Date: Wed, 22 Feb 2017 10:28:47 -0800
Message-ID: <20170222182847.wdvk4stm5gbt46ch@sirena.org.uk>
References: <1486422576-6958-1-git-send-email-flatmax@flatmax.org>
 <1487740949-27583-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4597581967821378171=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 899CE266E3A
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 19:29:06 +0100 (CET)
In-Reply-To: <1487740949-27583-1-git-send-email-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Eric Anholt <eric@anholt.net>, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============4597581967821378171==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="33msiqzta5lvne4a"
Content-Disposition: inline


--33msiqzta5lvne4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2017 at 04:22:29PM +1100, Matt Flax wrote:
> This patch adds multitrack capability if in DSP mode A and the
> codec is master.

As I'm pretty sure I've said before please don't send new patches in
reply to existing threads, it makes it much harder to follow what's
going on and what the current versions of things are.

--33msiqzta5lvne4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlit2F4ACgkQJNaLcl1U
h9C2rgf/S5WzNVBAVWUAjQMrQ+YJ+b3qNTjwgXLLCLR3ZEu/s2pYUoeSgRXTC3Uf
4f3BYTxQzGGIqdQCyNHNcGXtS6iME2CeBq1NyNMDw7rg7q62NJVTFZNtdL8fpn2J
9v5vgFc/A3rJIEPsplA9rVpzvlp78A5XAQUIRv9ucKZiW4xUqKu6U/cgaNkYWkdW
0eeB/cyaJbliZcQxOlkGZ9Xu6+tlHgJBpdDbrPp+J7XS5l5dBp5lKujO8HziZ432
zXj0Frb/GEJj/ZSMsHc1WtRDoaxo66qfNcRHP5ckGNZXUAMJIhdOXxaHNkGFIoBa
JLWBu82x1BypSyVnEOXchAoLT3tjIg==
=CArA
-----END PGP SIGNATURE-----

--33msiqzta5lvne4a--

--===============4597581967821378171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4597581967821378171==--
