From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC fixes for v3.12
Date: Wed, 30 Oct 2013 14:40:00 -0700
Message-ID: <20131030214000.GS2493@sirena.org.uk>
References: <20131030172553.GA8065@sirena.org.uk>
 <s5h1u32k5yq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2626960386159022085=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 25C9B2616E9
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 22:40:15 +0100 (CET)
In-Reply-To: <s5h1u32k5yq.wl%tiwai@suse.de>
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


--===============2626960386159022085==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3ig5MTpp3LwprTX9"
Content-Disposition: inline


--3ig5MTpp3LwprTX9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2013 at 06:45:49PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > A few of the Coverity fixes from Takashi, one of which (the wm_hubs one)
> > is particularly noticable.

> Thanks, pulled.  But I already sent a pull request to Linus early
> today. Will try again maybe on tomorrow or Saturday.

None of them are super urgent, even the hubs one was sitting there for
years without anyone noticing.

--3ig5MTpp3LwprTX9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScXytAAoJELSic+t+oim9u98P/j/2L272amAFyLugz1Tq6is6
bOnqNgVm1oxgkeTtSY9bTWMasrZZZ2DcdwAChLGCfv+7wqZwmfT+uqOWrD3ySQE6
lIojTJk4ChkgweAJHmLov4EsWmMJgJYWa6mZFqHrLzPtBuB2SFaDgKVozLXzg3Bz
1p8p3BOfa9kvVsHfvqlEBUTUxwt+Q6bEPfltzyUPo8mFs/bq1LbtcBSydq+kSQyG
0jHz5oSV+Yl+t+ssDs2yAVm+SteS8UWLAcdzv07eaeuyv1J9DouCKz31ks/NEWJy
U92zlIlAjpSw4cF6l86YMw1abK3JMrVhBrJKf0+J1WmSEH9Y/rVlNsSxWVXLaZUL
D25zEieJmwJN2Rgim3uNLzQAPbmFG753pDMtobvwhAN9OUnhjrD3dzhTrB29G5c9
8/Djx8qpndtqoJ1ezkYC8obLjiuygIbMIJjuBck9emQhsEJwHjBHNcjylt9adcgH
/2wNPLlc5ENd9A7WF4vVlkjnXgwT64yfKMimBfVr43PUUl6B/bwr3sd0XzUYmWul
I0zwgqc7Lgm4+jGvR4ah26ERKSluSsrh/vO5WZwZs7qf59RVHNmPCSM1iWitp2Qs
sEfTtNhmy29eEGOPy63R4MEI7r475WG0oX8N29/nFzV5UQNo6hxAXf1YVIbMuZ6r
JXdfvgKIDu2NCvtMKhbw
=6sA1
-----END PGP SIGNATURE-----

--3ig5MTpp3LwprTX9--

--===============2626960386159022085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2626960386159022085==--
