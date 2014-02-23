From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 068/102] ASoC: da732x: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:57:30 +0900
Message-ID: <20140223025730.GI25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-41-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8568392587092720797=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 182FA264F03
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:58:04 +0100 (CET)
In-Reply-To: <1392723517-12772-41-git-send-email-tiwai@suse.de>
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


--===============8568392587092720797==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G4GkWxNJALccptvH"
Content-Disposition: inline


--G4GkWxNJALccptvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:24PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--G4GkWxNJALccptvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWOXAAoJELSic+t+oim9QkEQAJ3LbJqVRccQnjKmpuC40PtY
SlFGDsta2rvz/gUAAbg8Jq5CPpILk2lpgOVnt9+qSiyNn5Fe4NdLfySXf9OJo7+J
8CiPg/fqvEf7IS/sH3hEwF0BkAzEDiai3rqhzV7F6rGvaD2HdXjvU6Q7SI7v1Heh
cuym4Iu7sjbta/whowaTD/VnP+pf8kcjXAtyLAgRrVTsr/qj4sNhs8WXs2+9uGEJ
JiP5Xa81FuNECLqGj7obZc9ppHRdiWimtc204swViOtu9rXJsxlMLUERLnGDNxog
lIESdLsRtRbrZJJ+bEJPZtNSY/Vks+cywVsmcYJJ6Kr0J9dnKJtEDW8JMqpOjvNk
1xc6KfQyc3hN/mUxJghQwQvf+mi37vMA93IAAZEr9XMX0CnCwnHVasaQ6pC6zbuq
C6+Vn9NutATHNFlmApIL5Ql7ZXj2CjpgrywfHJj7hINrIEz9X5XwvV2ybkrLzs/f
AlOcZmw1fQpN8HiEyiSgn8CuUhy3MW5acGqrSR9Jp1qcH20v42miIPbt5ALfqiqg
6tbFOg+QN4DkqV6TwBUcB+9U5KragK4Qe3pdwHToolDv6HvGJMDmyzhBEBAW80XS
ndpstlAv9ig4shocpids6FTxhobygK6wHIokVZ4YR+db3pfMeXlkZVCLisup+gxR
2Ksx+fGFlzWQZ5gxLTD0
=Nxeg
-----END PGP SIGNATURE-----

--G4GkWxNJALccptvH--

--===============8568392587092720797==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8568392587092720797==--
