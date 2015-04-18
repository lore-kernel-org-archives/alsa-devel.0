From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: intel - use
	SNDRV_CTL_ELEM_ID_NAME_MAXLEN
Date: Sat, 18 Apr 2015 12:59:38 +0100
Message-ID: <20150418115938.GK26185@sirena.org.uk>
References: <1429291413-30668-1-git-send-email-vinod.koul@intel.com>
 <1429291413-30668-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0468926836839213779=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A796F2619BE
 for <alsa-devel@alsa-project.org>; Sat, 18 Apr 2015 13:59:45 +0200 (CEST)
In-Reply-To: <1429291413-30668-2-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0468926836839213779==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aqWxf8ydqYKP8htK"
Content-Disposition: inline


--aqWxf8ydqYKP8htK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 17, 2015 at 10:53:33PM +0530, Vinod Koul wrote:
> we have defined SNDRV_CTL_ELEM_ID_NAME_MAXLEN as size of name array so use
> this define instead of numeric value

Applied, thanks.

--aqWxf8ydqYKP8htK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMkcpAAoJECTWi3JdVIfQO9QH/RKLG4ThDb+zDpFbbh/aNxHA
RHiOHvQkQh0HUKJRAJbPmR8aHzzaNHj+UcTzjerJ14H6RRI2m1ogshbr9Ii+FJ6U
7QPxoj24MGuxoOYmQWno/mygKQFqdJHgU97ehc3DXQFTHzfei5SyRhB0sXejtLoD
bNzK+8KEvWqdi1kouP0zu7YG4yHcotc4lAnic1GvmuTyeTvp2QMpwC9FPJycAEnz
5OwaXEH6wqW6Hr4pG8DPdcTsVEnUZ8IhZyLClUFoBKySADSW/Gvkapkzy6a6p9NK
ttrJqDNEDrNFDlSJf7rrYqEU7X10xJia58sycgDI9OlZl2huQ3n2Tbl/BfPRgIg=
=yOxA
-----END PGP SIGNATURE-----

--aqWxf8ydqYKP8htK--

--===============0468926836839213779==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0468926836839213779==--
