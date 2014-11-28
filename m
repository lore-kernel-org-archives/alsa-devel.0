From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Move capture PCM pin to PCM0
	for Broadwell
Date: Fri, 28 Nov 2014 11:39:58 +0000
Message-ID: <20141128113958.GI7712@sirena.org.uk>
References: <1417173643-25331-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8080786668555423075=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D95B7260447
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 12:40:05 +0100 (CET)
In-Reply-To: <1417173643-25331-1-git-send-email-yang.jie@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jie Yang <yang.jie@intel.com>
Cc: alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8080786668555423075==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nw8osqCVxPB7/Z45"
Content-Disposition: inline


--nw8osqCVxPB7/Z45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 28, 2014 at 07:20:43PM +0800, Jie Yang wrote:
> Move capture PCM pin from PCM4 to PCM0 for Broadwell.
> This will allow us to integrate with pulseaudio better
> for usually default device is set to 0.

This doesn't apply, please check and resend.

--nw8osqCVxPB7/Z45
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUeF8NAAoJECTWi3JdVIfQOlYH/1EGZN/8ZIdj9G6uf3XgfgdC
2i+hebMSEvHclrr6lO/wnMfejw70nM6piLh4Q6G5JIAbVKy1jmbYy2wxdCH2kTS6
mbTIpYN3ibKgVkDGop5CKCROUHbdxzJaW+WfbAWaS2CvzOsCCtkZLkuzgTqK5S+B
8MB7ZBfWBxvxAUNoai3/BpGEMcWZQlYrjOEFqmjSewlxwXYlJeYOLfRjd9bMW3MP
qhbFnfin1PnfHW+9ebsVizlUyKiHhm3/GF8iMqN9mdHBl/BgISuXgOmNMmIDxOZK
3aPsuJW9WmRPq0fXF+YLd7GjFIIpSlHvEQRa30+//qg/5MJaj3zuz36G9WvkbBw=
=5Rlz
-----END PGP SIGNATURE-----

--nw8osqCVxPB7/Z45--

--===============8080786668555423075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8080786668555423075==--
