From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 4/7] ASoC: Export dapm_kcontrol_get_value
Date: Thu, 2 Oct 2014 19:13:22 +0100
Message-ID: <20141002181322.GB4273@sirena.org.uk>
References: <1411125368-5836-1-git-send-email-subhransu.s.prusty@intel.com>
 <1411125368-5836-5-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0726414600287311906=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6483B2604EE
 for <alsa-devel@alsa-project.org>; Thu,  2 Oct 2014 20:13:26 +0200 (CEST)
In-Reply-To: <1411125368-5836-5-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: vinod.koul@intel.com, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0726414600287311906==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O/bkIMqRIB4oFlYr"
Content-Disposition: inline


--O/bkIMqRIB4oFlYr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 19, 2014 at 04:46:05PM +0530, Subhransu S. Prusty wrote:
> The DSP driver needs to know widget control value in its event handler for
> widgets like mixers. This is required in the subsequent patches

Applied, thanks.

--O/bkIMqRIB4oFlYr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJULZXBAAoJECTWi3JdVIfQmV4H/iu3YYu0nbyoWjtTQvLSi5Y7
vMK8sZa5GWP1ptMj7KO1sYvs6lvW3grZ4Vp0PBZSQ+tsdWYLBqD7C5qAyoOzFQfQ
a7Re3oLsHVo0LtIRq1Aucq1jtNeNnuHd/n3zElTXVz4MIIYEXTfAzGeFC6yj54k/
FPjIQWcbr8DxkpMaIlfpT8a2qHldYdI0oKpXwf8UrO6K11k8BBFMXQ0LAyw4gaeG
a1Yqru7ydqE7V18Em6emnd60gqgLnJSMwqfF6dvdrana2ie55198UDouyqNnNWSR
H5vQWD44vJXi5kRl03//xwUA7atRz2HP1tcvLi38UX3YCcRb2twmyzw/Pnh6lFo=
=Go79
-----END PGP SIGNATURE-----

--O/bkIMqRIB4oFlYr--

--===============0726414600287311906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0726414600287311906==--
