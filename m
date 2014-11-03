From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Remove snd_soc_platform_driver
 suspend/resume callbacks
Date: Mon, 3 Nov 2014 12:17:20 +0000
Message-ID: <20141103121720.GG3815@sirena.org.uk>
References: <1415007108-18895-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8278622679995923713=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A842E2604AB
 for <alsa-devel@alsa-project.org>; Mon,  3 Nov 2014 13:18:45 +0100 (CET)
In-Reply-To: <1415007108-18895-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8278622679995923713==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eMnpOGXCMazMAbfp"
Content-Disposition: inline


--eMnpOGXCMazMAbfp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2014 at 10:31:47AM +0100, Lars-Peter Clausen wrote:
> Those are unused and new drivers should use device driver suspend/resume.

Applied both, thanks.

--eMnpOGXCMazMAbfp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUV3JQAAoJECTWi3JdVIfQQc4H/RDoajpHTKzP4DipnV2tYCCq
w3i49rqLu0iukMz0eNthngf1zMJbjdFkP7rvOeIDKNzbG4a7x8YlAe8aWdzGaQ52
tdxxJRxQuPISTQK2uXBpy784c57ddhF76F55MI+7F4YNhZgHnoy6UwExvOTBtU6c
VAPQ8cjauZEYgqgibAdAET0hX9UzHGJeHPhT40UvzhAKIi/st2B/AByo4McMaSN/
wmXC9aufZpazOhyy/qTGH2Kes9dYt+dEUpzWEmexqdJoJNGcpsdU2COaAzAkOvti
qa2ZYkRs+7oQ9b6oH2NLb/kBYMdYzMJ0SlhGfgF1084EBrNrudHLY1u6Fh99Cvg=
=Q8YI
-----END PGP SIGNATURE-----

--eMnpOGXCMazMAbfp--

--===============8278622679995923713==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8278622679995923713==--
