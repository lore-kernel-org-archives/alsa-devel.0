From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: TLV320AIC23: make codecs selectable
	in Kconfig
Date: Fri, 31 Oct 2014 12:26:00 +0000
Message-ID: <20141031122600.GQ18557@sirena.org.uk>
References: <1414589138-1956-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1347419873654446224=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 04D7B2606B6
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 13:26:40 +0100 (CET)
In-Reply-To: <1414589138-1956-1-git-send-email-jcmvbkbc@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1347419873654446224==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpUlAaNTEf4O/sF9"
Content-Disposition: inline


--IpUlAaNTEf4O/sF9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 29, 2014 at 04:25:38PM +0300, Max Filippov wrote:
> Now that manual selection of drivers for audio subsystem components is
> preferred AIC23 codec must be selectable in Kconfig to make it possible.

Applied, thanks.

--IpUlAaNTEf4O/sF9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU3/YAAoJECTWi3JdVIfQyMAH/Rqry3+ZL97XRae52S/Cj3O5
D7AWWS2b6zscaML8e9k+4h+QTIBA/u/DIXqatkFU3P9PN9OPRnBPtfBqVyeDf8cO
nRjmFC+T1xkd/3zBepaQKnwX3j8tmA+1ENRQUScWp+FtKRauJMsRvmOsDSl7HvrX
HUmFStidwSSAaeNKC9aIUAyBgKAJPsmtwR3b6I/JbFlftRlqFHrh73oBoMFn9uSc
1jC81EfaB1i6iWi8wS+TE8UOhB0lFZhEvy0h6ua84BayoCuwC4jZWrZVPGewOqqb
CDmSuYHCNGGCIUnlokV2+BYGXUp5D3P86M7FHY+SrItNS98dMhSIgqe3X3mKKEk=
=TLAi
-----END PGP SIGNATURE-----

--IpUlAaNTEf4O/sF9--

--===============1347419873654446224==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1347419873654446224==--
