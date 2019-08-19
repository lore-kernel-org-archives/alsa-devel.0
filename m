From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: SOF: Add OF DSP device support
Date: Mon, 19 Aug 2019 21:23:56 +0100
Message-ID: <20190819202356.GD5563@sirena.co.uk>
References: <20190815154500.29090-1-pierre-louis.bossart@linux.intel.com>
 <20190815154500.29090-2-pierre-louis.bossart@linux.intel.com>
 <20190815164942.GB4841@sirena.co.uk>
 <CAEnQRZAM6VkCewfVYysz-NmPNEz-CSe763Cv-kz9kyNjx8uMtQ@mail.gmail.com>
 <20190819134616.GR5999@X250> <20190819192406.GC5563@sirena.co.uk>
 <CAEnQRZC_YFZJFbbwey8pQcAfUbcKxKjC88i-Zz7sJEG7zbUXGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0070719299146396288=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f98.google.com (mail-ed1-f98.google.com
 [209.85.208.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF4E8F800BF
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 22:23:58 +0200 (CEST)
Received: by mail-ed1-f98.google.com with SMTP id g8so3210447edm.6
 for <alsa-devel@alsa-project.org>; Mon, 19 Aug 2019 13:23:58 -0700 (PDT)
In-Reply-To: <CAEnQRZC_YFZJFbbwey8pQcAfUbcKxKjC88i-Zz7sJEG7zbUXGw@mail.gmail.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Daniel Baluta <daniel.baluta@nxp.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Shawn Guo <shawnguo@kernel.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0070719299146396288==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Content-Disposition: inline


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 19, 2019 at 10:32:58PM +0300, Daniel Baluta wrote:
> On Mon, Aug 19, 2019 at 10:24 PM Mark Brown <broonie@kernel.org> wrote:

> > Right, especially so we get domain experts looking at things before they
> > are merged.

> So the binding documentation should go through Mark tree right? We
> will update the
> patchseries and Pierre will sent v2, if I understood it correctly.

Yes, please!

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1bBVsACgkQJNaLcl1U
h9Bz7gf9GvqfAtuuz/fm+vQY42IZjRaH1Io0bDIuytyAWzloOe9iSuB2wAUiUmMX
rXyCHwxy6Wih99XxCSoek3lPdL88fFHnOLLt7+/BMUMx6gDaBLxXWl1Z/mN1BzgW
n4pGaHPxgudf9ld15QbKiAXk9jQ04JWnBh6nSoUinE/Fc+Re3Ve3isbdC6Ne+rPD
mFbyis/lLsMOdmPLDjmwgKgDrG3zCuXqa87bwTIQUhSLIwdExA+U0SnUm0N5ypLU
xQDbj1eL5ozvhjhVXDDDG62oWBISx7ConpTYUpQgKYfHzqTymlea0uPjvwYPLvUJ
08BeeRW97A9w/dYT9hSCxrhcvp6KVw==
=2gxi
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--

--===============0070719299146396288==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0070719299146396288==--
