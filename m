From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: blackfin: Fix missing break
Date: Thu, 14 Nov 2013 10:08:06 +0000
Message-ID: <20131114100806.GC26614@sirena.org.uk>
References: <1384359300-21219-1-git-send-email-tiwai@suse.de>
 <20131113164715.GX878@sirena.org.uk> <s5h7gccb5i7.wl%tiwai@suse.de>
 <s5h61rwb5e5.wl%tiwai@suse.de> <20131113184751.GB878@sirena.org.uk>
 <s5hwqkbqzf6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3603101323823416332=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E7753261A11
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 11:24:31 +0100 (CET)
In-Reply-To: <s5hwqkbqzf6.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3603101323823416332==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1SQmhf2mF2YjsYvc"
Content-Disposition: inline


--1SQmhf2mF2YjsYvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 14, 2013 at 07:18:21AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > That looks to be an issue that's very specific to OMAP4 - you need
> > someone who works on OMAP4 to have a look at it.

> OK, then could you assign to an appropriate person?
> You must have a better clue.

Peter Ujfalusi at a guess.

--1SQmhf2mF2YjsYvc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShKD9AAoJELSic+t+oim9TekP/11XrB2QDnUW6MmUykVQQ7y5
pleICamfG0bI+pDbUjv91rX0VqATpTCUvyNRrQfPV6U7hKUcyiOrpOcBdqE78Ue6
nndvKr5FspfPiJhhEDF2okKCHCeaRBfVEHqZ+q28Ec2fnI/vqR9MJ+CSP98yHN1L
8WcV/rOFU4fLEL0EXX9lH6eJLpg1B1oqciV/0BkNgXPmcy0LyGTNsIHQNuCXADji
ciyBVoFB7WKDwSV5F+QmoPL8hzjBBlcppPrFNYvW3HPvoA3RYNCbtFPIHBLyBg/9
tqebYIwDPbfC4/RtZdb3/Avd9mHwP72ZIrEfAFpws2ZRryZQtKAB1zrUvIocMKcH
eoz7o1v/UkUmS0ePdWT6oyf72RCeO/edWroUTwey6VSjUoTgvwit64PA8D85g5O7
Z/OfIT5C+qO5MJAdDroVvwrzmmjjuyV/KgQF2mmJX15zZGvYe71zSS0gKt5rcOHd
8ivQVKtOEqSMqR5+S6qeO36n+KQnCC0AC4BfDKn112SVDEFylw0JsINo7goMX8hx
4nZAwCV6OVnyq+wpQti9vVnvWrQ+d5O/FW7EA9trugnybpHENNKIsfnibImJN0ge
PwIxWs2PGGtwKUK37hhtc15SVzPhLVKq6kE2NkK/owdvh8lcO7JxUQm0KWwnwSA3
5ApwFI4nS5WEpXfoZRU0
=sZw6
-----END PGP SIGNATURE-----

--1SQmhf2mF2YjsYvc--

--===============3603101323823416332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3603101323823416332==--
