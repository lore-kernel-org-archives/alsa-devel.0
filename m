From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm512x: Implement the digital_mute
	interface
Date: Thu, 6 Dec 2018 14:41:32 +0000
Message-ID: <20181206144132.GC7982@sirena.org.uk>
References: <c18a7eef-4919-eb16-7f3e-fc4e2199fa7b@gmail.com>
 <20181126140200.GC9715@sirena.org.uk>
 <CAHEwa0BPZWFQLok5siyK7Dj43nChFF3sPwGxAO7ffpwheFdeBg@mail.gmail.com>
 <95f88de0-ae1c-7618-7edf-9631d09d95ba@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6781441468210953143=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 231FA267BB6
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2018 15:41:35 +0100 (CET)
In-Reply-To: <95f88de0-ae1c-7618-7edf-9631d09d95ba@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papavasiliou <dpapavas@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============6781441468210953143==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 03, 2018 at 06:26:09PM +0200, Dimitris Papavasiliou wrote:
> Pinging this, in case it was buried under other messages and has
> escaped attention.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.

Sending content free pings adds to the mail volume (if they are seen at
all) which is often the problem and since they can't be reviewed
directly if something has gone wrong you'll have to resend the patches
anyway, so sending again is generally a better approach though there are
some other maintainers who like them - if in doubt look at how patches
for the subsystem are normally handled.

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwJNRwACgkQJNaLcl1U
h9Abzgf/cz7Pd11+F9/6H3plj1ka8C1J312F3JmIsvWJ6tr2psB5Ju/GrNKc7RVn
u4An1329cLDbNT1CqQGM8slPs17wblG89WGSyVGp3P9TYVSZ9U2u2HFP2y2gmdOw
uUTK4LRaHYJ6HYilW0JLPh5nvdoJoKGyjMxvmyzQkHexFXdRQ9pRMQY5fUN9kugw
KYzIwuUXZvkqyX1LU1881wiyoJ748V0mvOD3yocT5adDmZQCsd0HUUm37hU9yPzK
3b+kt+ckICKGoRMrYlbMSFubgKD1NDuSjIlfrUiRezL2mi3kODSD5Fw2v4x72+2O
IG1MveCS8VpfNE00I/IRlkzmmKBSQg==
=69w0
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--

--===============6781441468210953143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6781441468210953143==--
