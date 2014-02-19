From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2] ASoC: Intel: Rename SST trace event
 header to be less generic.
Date: Wed, 19 Feb 2014 13:27:32 +0900
Message-ID: <20140219042732.GV2669@sirena.org.uk>
References: <1392723796-4773-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4854078228062475743=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E4D3265327
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 05:27:50 +0100 (CET)
In-Reply-To: <1392723796-4773-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4854078228062475743==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YMf7pJGz0wcApMUv"
Content-Disposition: inline


--YMf7pJGz0wcApMUv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 11:43:16AM +0000, Liam Girdwood wrote:
> The Intel audio DSP SST trace event header has been renamed from sst.h
> to intel-sst.h in order to avoid any confusion with any future
> Samoa Standard Time drivers ;)

Applied, thanks.

--YMf7pJGz0wcApMUv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBDKxAAoJELSic+t+oim9cTsP/1imdBa3tujd7Jgj/vFEKoOr
/Uti7vFanOrxbzycAQXlBZG0sT4ndTh1JzTSwPHs60dQh99D4jR2puFasxae4o8T
ZBQ4nymfC+KNxLz02erR032lCd5Z60fsiwdZV16gfhuJr1Ec9rLuYCyMbeZroHXr
nCCqAq1h/4jda58U65NITvinVxChg9kZbTawfBsjKUMXa0TdG/dff8BT2ufd2fZ/
3OQ/sohkth08RDTCJuyqyUE2ghSfvoV0VwF6tueRw5O+xV8oUrdPUWcMcZWFBC7M
mqOr2GYWos/A7tqA9q9lWZblQeyTgpVmF4VMiAUzPS3Jo4XKbdAH4Op8H79kouBi
Oe9OfWtHqLRFij5bS1in/xJC3CCDFUOihjByOILfnv2MTuZteFIc7ibYoue+qQ2F
nmBpPqeHhxy4fC51Yg/3I1frJMFonARuKmgLcR/4Dif7Ld/XsFm40R/yg64xCmyw
jjyikjVkcmhVhzp6WCVbjk1zlX6oveTM8B7F/x8+WqO3TKpszifPXDbmjzc9yDFa
p1BAAQuuoqs8nXAyFtFb0rszPMKrhsrggeNmqycpDIoLWAN61n35fNWlWRZQeh0J
edufoXB5/xlMtHsqp2SL5DVZzYATvUzmzBCHSu6p6at64H8wJDehZYL4O5DpVrzX
KWs1ywyx3uSSEwsG8lyJ
=mKOw
-----END PGP SIGNATURE-----

--YMf7pJGz0wcApMUv--

--===============4854078228062475743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4854078228062475743==--
