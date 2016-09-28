From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/5] ASOC: da7219: fix inappropriate
 condition statement
Date: Wed, 28 Sep 2016 09:49:10 -0700
Message-ID: <20160928164910.gs2vt6g7umyiceom@sirena.org.uk>
References: <1474929911-6005-1-git-send-email-o-takashi@sakamocchi.jp>
 <1474929911-6005-2-git-send-email-o-takashi@sakamocchi.jp>
 <c2589b20-a5e3-0026-8f76-3d749ce006d5@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8770414206362509388=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F311D2667C9
 for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2016 18:49:21 +0200 (CEST)
In-Reply-To: <c2589b20-a5e3-0026-8f76-3d749ce006d5@sakamocchi.jp>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============8770414206362509388==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="v6agkqistpq63qst"
Content-Disposition: inline


--v6agkqistpq63qst
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 28, 2016 at 09:38:31AM +0900, Takashi Sakamoto wrote:

> I have never received your 'applied' message to this patch, while
> received the others.

> This patch should be abandoned? or I should send v2 with corrected
> subject line?

Please allow a reasonable time for review and for other people to
commment on your changes, this change was not so trivial as your other
changes so I've allowed longer for review.  You sent a series consisting
of a bunch of unrelated changes, it's likely if you do that that some of
them will get handled differently.

--v6agkqistpq63qst
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX6/SCAAoJECTWi3JdVIfQn4gH/RJ+ikDjTzaYyXKyg9dQ7VvC
7PSSNp38roYdB1NyXoik7uOu0pu/81v9mpELErfDWqeglntT6JWYfCIZASnsFWLz
XeBPAG5x/l8dV284OKcduxZiyo4TupYNxd/LjPEVYTeENMvpS3svRc267QAjcj/+
RGiX6fn7/th5xaJmAmPRwiHgx9wePY/mbN0oVmCwhdXeA7zkTkCC5mzZmbaQFl9s
NXY3sdgsr/b7V6d3XugrVOreqyY2RmKt/F7cIcoFkk1vmlVIqK2bp5CpmABWNIVI
VV5F05LcBsJ1gznUvX2mqHrlZwHUfw/EmLSqD39rhLtfT3tzkceuV1nWVm8pBMU=
=7CBd
-----END PGP SIGNATURE-----

--v6agkqistpq63qst--

--===============8770414206362509388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8770414206362509388==--
