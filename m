From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/19] ASoC: Intel: mfld-pcm rename period
	callback arg
Date: Sat, 21 Jun 2014 11:43:17 +0100
Message-ID: <20140621104317.GD5099@sirena.org.uk>
References: <1402662848-24534-1-git-send-email-vinod.koul@intel.com>
 <1402662848-24534-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2369971529515639024=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 435A62652E9
 for <alsa-devel@alsa-project.org>; Sat, 21 Jun 2014 12:43:22 +0200 (CEST)
In-Reply-To: <1402662848-24534-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2369971529515639024==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBpVdUurH6AOd0Py"
Content-Disposition: inline


--gBpVdUurH6AOd0Py
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 13, 2014 at 06:03:52PM +0530, Vinod Koul wrote:
> The argument was called mad_substream which is no longer apt as older driver
> is not used anymore so rename as arg

Applied, thanks.

--gBpVdUurH6AOd0Py
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTpWHCAAoJELSic+t+oim9sb8QAJkrqQTo8QaT1+YmspQabqy8
d6kc7PbTxEueNuo57NclLIamJozwiqHwkKO3M/QSKdqSVdg+Q2/i9Z00uw0OV/K7
lhfMsDfJGtG2xePWLkfsnSUbY9BhXSuTaUwxmfJlxZsnbFHPpVu+1i8SmDl6mXdy
n5Zn7AES2paMZd6kPELMwV/9gqiI5kboC589LjyGa+6QXf8y5gX6TJcCcM2PqVlg
4oWmnrIn+HlsQw5bVJrHn+oczyx8KP69LskqXzaPDE4gPH8PPGygTP+R8Iz63dvi
XScHAmB+lSOzyajRIonnLQHM5BD+733IPov4IFuo+4F8qmDMpFoQyBjU014yjztZ
p6OlBUx3gHVxztkyQdwXjXlrImn9g8WuUH/c1ojZqMce0EDfbepiF+E4QgQAMcUh
0ocFuzZzmJAtwMCgYuh5nqndAJCoc9JJo0QWWZd1WnBbfiAFJWQMeyEyHD42HSgL
Wlsm2DXMRgFPSTJ3nxPSd+tWuIyR/a1VksPm/7oc0pDy7lA/HzUEwXJBL6OGG3Da
Kb+TgATYNeSrIyyBaAGF6R6obq3WUXtruhfGRAjVeCCLPYgqAhmE6i5pmcAIedsc
7XJO3wLJBNksFd0Sf1qj0Z4/jt+gVAn5RzTnYQHBDfz4qo0V8/jzcdbKZiWPfsyn
esHeW/46y/uP4iOhlD/d
=CoYO
-----END PGP SIGNATURE-----

--gBpVdUurH6AOd0Py--

--===============2369971529515639024==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2369971529515639024==--
