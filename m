From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: dapm: Add a helper to get the
 platform for DAPM kcontrol
Date: Mon, 26 May 2014 19:54:59 +0100
Message-ID: <20140526185459.GL12304@sirena.org.uk>
References: <1401106136-3745-1-git-send-email-vinod.koul@intel.com>
 <1401106136-3745-2-git-send-email-vinod.koul@intel.com>
 <5383419F.9040105@metafoo.de> <20140526162345.GG21128@intel.com>
 <5383714C.6020809@metafoo.de> <20140526164759.GH21128@intel.com>
 <538382F1.8080506@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2994535893956574498=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E8C526545F
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 20:55:17 +0200 (CEST)
In-Reply-To: <538382F1.8080506@metafoo.de>
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
Cc: Vinod Koul <vinod.koul@intel.com>, Kp Jeeja <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2994535893956574498==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aW9lYAu6M9O6B01x"
Content-Disposition: inline


--aW9lYAu6M9O6B01x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 26, 2014 at 08:07:45PM +0200, Lars-Peter Clausen wrote:
> On 05/26/2014 06:47 PM, Vinod Koul wrote:

> >>It hasn't been merged yet.
> >Okay, what is the state of the series? Would it merged soonish?

> Maybe, depends on how well the review goes. But it doesn't really matter
> which patch is merged first, we just need to be aware that the other one
> needs to be reworked and rebased on top of it.

Probably not until after the merge window now; that should open next
week and it's a bit invasive to be doing right now.

--aW9lYAu6M9O6B01x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTg44AAAoJELSic+t+oim9qu8P/01+swL/aiBhkmLvpDKgtdad
h9O5Hq9DA3gjtmUbC2s0tvCv7scdm+F1ydWZCE1mpTF7d5h4FmPdc43C6kzV/anh
Ot8qQSocCd5hypudYDkrViqgSJaBxGwBhn9+QgjtS2s39RfXyz/Nw4KLr/rBBri4
hcxhUjtfaJlk8cbuuvL8zJwDnNh7gM2CnQhi+5W7rQO6N88ZtCPcEjCPfVLKOLHh
6OzWF/kboCopCGc63mvLSuQOZ8WyySg6qpXEGLGNiGYp1W8hpHbgcMmlDIHTre++
o1R9VRjGMfFjWN7ygOCS+Eh0qHrNV02+kGjNMnChAcZnvOfSaFjDJL0YodG2RD47
+qf61Mts8vOUBhzDXC8P7g4Rd8AeMmWyeOiB5jET64GCPGYGd6Q/AuabTjytpDQ8
UmJn2kyFsm/dixnJNmAHnozF1/Inf+SFxMzf1ZzPwhevAzDYvrQiq4l8VRJlwuyV
6wkkw//aOJfhkPXnUQFBPPCpbVsO3Y4l92RA+JwYe5xAaKoYXsJrfmzWEeyuhe6A
UGJMFyx+VZg54q6eUziObLaVfolGX3Lk3C62vjGi6iY3DZKZ/wDibE6rd6CTOXoN
XpsYuAm2UcR2c5eYQulun+bk4vk0m4GkpwbIwRn6siwAnex2aIepKMpm1G97QD/X
4N6mocKny9I710Ezf7r/
=mgPU
-----END PGP SIGNATURE-----

--aW9lYAu6M9O6B01x--

--===============2994535893956574498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2994535893956574498==--
