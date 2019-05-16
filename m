From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt1308: Add RT1308 amplifier driver
Date: Thu, 16 May 2019 17:52:59 +0100
Message-ID: <20190516165259.GI5598@sirena.org.uk>
References: <20190417150518.GB5703@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B828011660AC@RTITEXDAG02.realtek.com.tw>
 <20190508064537.GN14916@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B82805B1144E@RTITMBSVM07.realtek.com.tw>
 <20190512080621.GH21483@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B82805B13EE2@RTITMBSVM07.realtek.com.tw>
 <20190513145608.GA5168@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B82805B14BFF@RTITMBSVM07.realtek.com.tw>
 <20190515161429.GH5613@sirena.org.uk>
 <BC6F7617C38F3E4E8CA887E07B35B82805B15635@RTITMBSVM07.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7559080890686009165=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD47DF80C18
 for <alsa-devel@alsa-project.org>; Thu, 16 May 2019 18:53:11 +0200 (CEST)
In-Reply-To: <BC6F7617C38F3E4E8CA887E07B35B82805B15635@RTITMBSVM07.realtek.com.tw>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Derek =?utf-8?B?W+aWueW+t+e+qV0=?= <derek.fang@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Albert Chen <albertchen@realtek.com>, "bard.liao@intel.com" <bard.liao@intel.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7559080890686009165==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X0cz4bGbQuRbxrVl"
Content-Disposition: inline


--X0cz4bGbQuRbxrVl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2019 at 01:46:53PM +0000, Derek [=E6=96=B9=E5=BE=B7=E7=BE=
=A9] wrote:

> > It's better to have a comment than not have one, I think I'd be happier
> > if I understood what was actually being limited here - that might make
> > it clear why it's not system specific which is what's concerning me.

> I will give a comment that describes the limit setting reason clearly.

OK.

--X0cz4bGbQuRbxrVl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzdlWoACgkQJNaLcl1U
h9B7yQf/a95gVfuo5W6rYTxbjFPj4IUC7975Ts6OAP8/9XCz1UW/YXAQUKSUHbrd
voLJEJp2hECn6NlEQgww6E1VsaqUSpDqQvBUhZ0670Pe6dvawGj26yGUBJm74Eln
0k23vNGjyJH4mQECUznrvGYSpRyjqfb/fE7rxj/uugZUfx47DIrSjyJnb4TRGK/C
yNKgKDLqE7oAC6Dmwp5mmXfdemuwdQL3ZJSPCGtoxB9/QBAyItftwRtN3wKulw1Z
izRy5QhbxD9vBciJeN/fa6tT84Ko6fLkh6pxlW896dyrRwQZ6KxoxlalL7QWSk3i
WVGs20P4fF3cMNU//TdpIW6wVEjoPg==
=R929
-----END PGP SIGNATURE-----

--X0cz4bGbQuRbxrVl--

--===============7559080890686009165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7559080890686009165==--
