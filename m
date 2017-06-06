From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5663: Fix the IRQ issue
Date: Tue, 6 Jun 2017 18:04:40 +0100
Message-ID: <20170606170440.c672i465ebogem3a@sirena.org.uk>
References: <1496732394-21460-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5286866238364776861=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EC36A266C9A
 for <alsa-devel@alsa-project.org>; Tue,  6 Jun 2017 19:04:49 +0200 (CEST)
In-Reply-To: <1496732394-21460-1-git-send-email-oder_chiou@realtek.com>
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


--===============5286866238364776861==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3ycajcz4unlpozmk"
Content-Disposition: inline


--3ycajcz4unlpozmk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 06, 2017 at 02:59:54PM +0800, Oder Chiou wrote:
> The patch fixed the IRQ issue.

This isn't a great changelog - what was the issue and how is it being
fixed?  I'll apply but please pay more attention to this in the future.

--3ycajcz4unlpozmk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk24KgACgkQJNaLcl1U
h9CElAf+O8v5XVcKiSmIgfGGgG/+821PRY9RP/OVQn3pV0mPEvSlzTgc7eUXqDme
vdShv1Jk7F8o+o98HLpwDDG13/guSMaa2soVaVsh3jMsDyfQfjp3JE19YuPXL2LV
hTvR8xBgvhKeDi8vX4rK1d0wyOzW0QXcsMU6rm4kysT5M/WejrfNlLP4Tw0SI7zz
y2eYRGBXBeTKff6BUg6MGYmxrzT51MFLkYOLpc7R9e1glHpt+ezuNB88znvDX8nI
zx+ADhQ4i7vawcd2jd/uoH/v5AOA/RErfB2DYSj0JOSylRCcnr5y2jeQTFXeFc9y
vFz6PM58bricnVufYJ/qqCjvwZjjlQ==
=CWEr
-----END PGP SIGNATURE-----

--3ycajcz4unlpozmk--

--===============5286866238364776861==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5286866238364776861==--
