From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v2] ASoC: SOF: Intel: hda: Make
 hdac_device device-managed
Date: Mon, 15 Jul 2019 20:35:25 +0100
Message-ID: <20190715193525.GB4503@sirena.org.uk>
References: <20190707235633.7114-1-ranjani.sridharan@linux.intel.com>
 <7fc6fdf3461c8faff4d853f80e282f3830a04724.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1972974111910854007=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2D76F800C6
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2019 21:35:37 +0200 (CEST)
In-Reply-To: <7fc6fdf3461c8faff4d853f80e282f3830a04724.camel@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: tiwai@suse.de, libin.yang@intel.com, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============1972974111910854007==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2019 at 08:27:55AM -0700, Ranjani Sridharan wrote:

> This patch is needed for the module load/unload stress tests for the
> Intel platforms with SOF. Could you please help review it?

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

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0s1XwACgkQJNaLcl1U
h9B2dAf/d81W9qjuyvaXzR/iy0mjye0GkYW5M0RY9uteDwAq4XHwBRSb5rK19z4X
2Q5KMX2a0A+tSR36Pl4pEXnzGN8lWrh/IeSUgdgfi/SV1fXnqaHhFi11Fk8HdtAt
TeX5AtAj9l0c8Sel+H6TcSQGVk6+ucuiz6NZTLPEeyhiLp1N4E1GFPZNjN8Iorop
PzNJz6vKpFlgrGtaw85F52mrq8Q910RJxIJsBGz8LpOkGHRopkVEFJLQ8UZUMoCS
m5x91YrHfuJvZsm9rALHyotlO+5u5B6N+R8cb2vrO9RykNjuwW4tuAFBIHf1Gauc
E8TCkIs0wlUWesoqMfdZX3Q24xw1Ww==
=Vn42
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--

--===============1972974111910854007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1972974111910854007==--
