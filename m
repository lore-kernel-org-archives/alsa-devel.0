From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5663: Modify the default value for
	ASRC function
Date: Mon, 17 Jul 2017 15:26:52 +0100
Message-ID: <20170717142652.6izxn7wptjl6unpz@sirena.org.uk>
References: <1500019873-30391-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5510225271834968163=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 959A4266EEB
 for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2017 16:27:01 +0200 (CEST)
In-Reply-To: <1500019873-30391-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, albertchen@realtek.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============5510225271834968163==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e5n7uwbepikmckwz"
Content-Disposition: inline


--e5n7uwbepikmckwz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 14, 2017 at 04:11:13PM +0800, Oder Chiou wrote:
> The patch modifies the default value for ASRC function. It could prevent
> the pop noise and recording no sound with ASRC function.

This doesn't apply against current code, please check and resend.

--e5n7uwbepikmckwz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllsySsACgkQJNaLcl1U
h9Dgfgf/WR8I6biiiR9tQAklQ23BYlWAlbMEog8idqflATUh053mbDALG96tV1YF
Ndt0Oh1iJDD80ptnjAId3ZezJ7yFQy0dqt9FG1DguZXauz7o4hufdjVQtVzXRhsm
579C4TerN5zV9gcf1zBPsvXkH7yiubIRD2DpkLDAkvQ/85+A/KO/vmumU+vnnkmf
5x7iPGghzd8P+sqIg+S5OOqK6HFOstQEGYZLydJ5rNqN6jDnTGpqdpHNKDdsvbNl
U0CIYydAke5f/US6Pr1+/DrEDbWWbHvPMSigGU9DMhtDK85rWoPFTA9CudP2D1vI
zsyOflAy8/H0dOW1EgO/4Ye0xsWZLQ==
=petl
-----END PGP SIGNATURE-----

--e5n7uwbepikmckwz--

--===============5510225271834968163==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5510225271834968163==--
