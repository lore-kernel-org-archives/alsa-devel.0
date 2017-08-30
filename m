From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5645: Add jack detection
 workaround for MINIX Z83-4 based devices
Date: Wed, 30 Aug 2017 22:12:17 +0100
Message-ID: <20170830211217.5s3ubddjrpngkbb7@sirena.org.uk>
References: <29ad0cbd-b58d-70e3-0647-a2d633b7e57e@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7956029486896301517=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 219D1267217
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 23:12:18 +0200 (CEST)
In-Reply-To: <29ad0cbd-b58d-70e3-0647-a2d633b7e57e@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ian W MORRISON <ianwmorrison@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7956029486896301517==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tco6obknnz5tjmuj"
Content-Disposition: inline


--tco6obknnz5tjmuj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 31, 2017 at 07:04:31AM +1000, Ian W MORRISON wrote:

> v2: Applied and tested again sound -b for-next and linux-next -b master

You're submitting this to me, it needs to apply to *my* tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git

--tco6obknnz5tjmuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmnKjAACgkQJNaLcl1U
h9BX+Qf/W5JOvr+LM2nMNN4T8PDw9sI0qm0gKWuZQRg1t4yS3igDjCq6OfxFaZ1R
hrH+gHSea52Mz9Al71a1yHtl6+49NCec9CLMu1b0vu2lrpWhxG+uHc14HZOFlNnL
+XLZIMHT8gxi479kCJuYHzC7xe+bEakDKWhmXQynHGRCy7YtUOUUOeDe9BZv0dPJ
uietUZj9cVNyNTaRGIE6MQBcvinMCHMTGCGclUhrn6CKS2098Wezf82qMHkFRmTz
hOzTXpZ5HhzUDQMwgzqFcQZ3R4deb/+tIQotVXwMkiZ8FlNr3TbALXvutAw8UEYy
zU1hgO7bvltRhVus2sH65+WqCidyiw==
=JK1p
-----END PGP SIGNATURE-----

--tco6obknnz5tjmuj--

--===============7956029486896301517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7956029486896301517==--
