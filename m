From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adau17x1: Cache writes when core
	clock is disabled
Date: Thu, 4 Feb 2016 19:34:17 +0000
Message-ID: <20160204193417.GR4455@sirena.org.uk>
References: <1454594719-17270-1-git-send-email-andire@axis.com>
 <56B388DC.40601@metafoo.de> <56B38938.40000@metafoo.de>
 <20160204190129.GA32441@lnxandire1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6713973336027070492=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 28E4E2619D0
 for <alsa-devel@alsa-project.org>; Thu,  4 Feb 2016 20:34:30 +0100 (CET)
In-Reply-To: <20160204190129.GA32441@lnxandire1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas =?iso-8859-1?Q?Irest=E5l?= <andreas.irestal@axis.com>
Cc: Andreas =?iso-8859-1?Q?Irest=E5l?= <andire@axis.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============6713973336027070492==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d5xRKMqY7hkGAt+u"
Content-Disposition: inline


--d5xRKMqY7hkGAt+u
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 04, 2016 at 08:01:30PM +0100, Andreas Irest=E5l wrote:

> I posted a set of patches a few days ago which added DT support and
> fixed minor things in adau17x1, but I realized I was clumsy just sending
> it to the alsa-devel list and not including DT maintainers or any
> maintainers at all. Would you have a look at it, or do you want me to
> resubmit the patches with the correct recipents?

I'm not likely to look at things that don't get sent to me.

--d5xRKMqY7hkGAt+u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWs6e4AAoJECTWi3JdVIfQwAoH/0Tqx5mY2dmXDtLpeWvURGqq
zMzCO+qJkan92l1Sx8XEmTXZ6X25z38BLBrpOxkPUaJj8SN03WwUoj/hrLO6ak5W
375GF922H0sDQUMaWa/graEfdizhVEXHleccmgJZ5LHwz2Ki/92zWz33vXXRzvgJ
+Q3pKNzrwLbVlXHwnPrdoLeoQmKUBJHUa20lyXi3Kyqt8HHhgP5kh9KUtC0FEPUz
bqpDV4mFUF9lo52z2YDTZBDmJAPbDO6E0BRMek/dFqXAGQyu8YPfitjnZwjEfegU
Tx72zzaWOp84qpNy9TZLrX/Hfmf0QELB9SuJk3cgKqVnaoCMxdSxDZfHUjqqs7c=
=PiSc
-----END PGP SIGNATURE-----

--d5xRKMqY7hkGAt+u--

--===============6713973336027070492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6713973336027070492==--
