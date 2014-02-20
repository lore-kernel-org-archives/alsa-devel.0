From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 029/102] ASoC: adau1373: Use
	SOC_ENUM_SINGLE_DECL()
Date: Thu, 20 Feb 2014 11:12:22 +0900
Message-ID: <20140220021222.GH2669@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2860540715763284134=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A497265660
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:24:27 +0100 (CET)
In-Reply-To: <1392723517-12772-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2860540715763284134==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="amqTmuw0BTM/CXB+"
Content-Disposition: inline


--amqTmuw0BTM/CXB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:45PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--amqTmuw0BTM/CXB+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWSDAAoJELSic+t+oim9mwcP/i1iaAs+N3d+D1h9ji0tQeDH
rJ/AsCPulyg8/IoHp5iRBN4o7MTOp77jw3Mq8oeScZLAWlNzR1o+hW7ZNtvvKc6m
h5JteSmQg1rWU3ImMZo0YEO4akfCQ+LlZ4TNS6YePAAjZZLBOAxNeiIdBY+WMkfE
j4dCELF67/fnlrqqs+xBNbKPm9dqesg5ZBt/1iLnykkt502wSb1/siHur8dzTs9q
N4zbjOrsbEAjPq7zT6ETG7T5eV5qu34ibeP4veeYXCw9lfXoONtr6zgw1diTDeXm
LDz2iuls7ZldKL2eOurxLjpVan3YHE42tgscjqY9Hfv6fI7zaLKjHRQXR03OrqEI
tWUeyzh1wNddmqhxceJtwXw+L89u/uqGsNpuaQ39RZ6TzN9twDjvYLj8LSQtr9ZL
YcJHdnHEoYh+io2uVrWI9pa1WwlipHYE4euhLWeS2M02SkRhgRv2J3wOrjrEuv0B
hzsCwgm8CJNfaFPY74jRlSEqR4uPdAev5iIJ9QIsfaGqhy50Ga/WNnfAwQogr1Le
BX4A7lSrFFOBWpvmvMhHwR9zOFCAXGKlTt86h7vo+zVlyJFmbpu/UqO7DrtBBVy8
dOl0ppnZdNWyTqNqhwwrZkNnu49PjXlze9vZcrE4fLgAbigV5vdEdB5CU224zW7b
KdtwAqwMxhUmgCGjSkdK
=LyPV
-----END PGP SIGNATURE-----

--amqTmuw0BTM/CXB+--

--===============2860540715763284134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2860540715763284134==--
