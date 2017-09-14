From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "ASoC: rt5514: expose Hotword Model
 control" to the asoc tree
Date: Thu, 14 Sep 2017 09:05:52 -0700
Message-ID: <20170914160552.kudvxhbofgjwpxhz@sirena.org.uk>
References: <E1dkpi0-0000rj-Vu@debutante>
 <d9e62043-fa21-7159-c310-86c962ffb8e0@sakamocchi.jp>
 <4cb3fcb2-1182-956d-3594-92a654274cc5@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1336746330440869465=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 075CE267202
 for <alsa-devel@alsa-project.org>; Thu, 14 Sep 2017 18:05:57 +0200 (CEST)
In-Reply-To: <4cb3fcb2-1182-956d-3594-92a654274cc5@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: oder_chiou@realtek.com, dgreid@chromium.org, Hsin-Yu Chao <hychao@chromium.org>, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============1336746330440869465==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qr5ox5ldccwyyvrs"
Content-Disposition: inline


--qr5ox5ldccwyyvrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 14, 2017 at 02:03:29PM +0900, Takashi Sakamoto wrote:
> On Sep 14 2017 12:54, Takashi Sakamoto wrote:
> > As the subject notes, please revert the commit including the below lines.

> Ah... I forgot to modify the subject line as 'Please revert d18420b0a0b8
> ("ASoC: rt5514: expose Hotword Model control")'.

Please send a patch for this with a changelog explaining why.

--qr5ox5ldccwyyvrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlm6qN8ACgkQJNaLcl1U
h9DZBwf9HenRv5wQP91jU4c/xHwweTGS59BrGViOSSQDS7WK84o1OmuZbU1V7aBl
sV9D/1VZDpkpOWwHVqZbfSqsAyWei8w4OSSR1lswwqZOM/8QFqareJPKuH47QuUb
Mz7it7oemvwB47oGo5AaCK2cGBltzNc09t49jG1AQ/HuZxoKbjy/Ng0ppsz5hGE+
HFG1nXF7lJLL4NogjXCvRWJ+U6RMru2dUREdDn4KdpLlTzkncA9G/bDECPxc8nEj
yBEHadBHaR+OJV30F8rKJb5GW0NQaF7TBLigcudUK+SbRmEiyFuyvMHuGKp39zce
kqgZdiJ05e7xK9fDP6R7EuIwAxntoQ==
=Yrzj
-----END PGP SIGNATURE-----

--qr5ox5ldccwyyvrs--

--===============1336746330440869465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1336746330440869465==--
