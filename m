From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 051/102] ASoC: wm8737: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:36:03 +0900
Message-ID: <20140223023603.GQ25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-24-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2999452004808268499=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BC3F265134
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:36:42 +0100 (CET)
Received: from e0109-106-188-159-64.uqwimax.jp ([106.188.159.64]
 helo=finisterre)
 by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1WHOvo-0008Q9-Uy
 for alsa-devel@alsa-project.org; Sun, 23 Feb 2014 02:36:41 +0000
In-Reply-To: <1392723517-12772-24-git-send-email-tiwai@suse.de>
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


--===============2999452004808268499==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C6e6/dnRACxPVebH"
Content-Disposition: inline


--C6e6/dnRACxPVebH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:07PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--C6e6/dnRACxPVebH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCV6PAAoJELSic+t+oim96X4P/iMQQm48FMggM6159icPzjtL
/j6cY4rSmg71ZgeZHM9FHjVDYKzeGm2KMhiiIQkza4Upd50F0gwCe7qqMM70mx/E
GYeESICIN7h0TL3KrykuSgyUjfG+60VzBxjfNFkyaxSwDM3+wct6GIPn6S5gr6nO
p8uuxxXEW5+uoVXGBTj3lAKrw38dKRlIWS6pXWCoXRvhH+KnA0PMaDMATB+XeVyw
E0MXOsVr75ersQbk9BrfA00e5FbHD85gN+Eyf1qrxitt5+PqEAVGGZtbfoDlKkbK
PuxuxLmyEN1wml/C+ADnBvTdtFGsq4mE0sM9A05AfXKa1aIEs4HqARLN4/6FLzws
goUddnhTRv5rLf5fv4aja6tubvubrouIQ578Gs3QAIAMWiBhPkVz4YNCzPK80FFx
+3LhgCDJQO+VZ8asDmfzTLFpZ/eQzIbI5hxi0t+YKDqL5Vipr/CbAFKrSh6g8MBj
AKeqPuucxRPpuuLxAfuVsygnghUHWryGhVI3nixfKPrSKHMTwH1YTvnZVxTjIFOU
AFTvkQweAmNJPWwyN4DGugebEsjjQlMd9mgQNRLMZ+6wDXKd+JJbrMocivdCXMnJ
Ycbn+RWXf7yCRu8W9w/uLYWPOF44qhcltZq/cTAGzRFF43ay20Vck78QYJm9wUYX
OSzo0Bgq3iRzbYpYEhUZ
=aNB/
-----END PGP SIGNATURE-----

--C6e6/dnRACxPVebH--

--===============2999452004808268499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2999452004808268499==--
