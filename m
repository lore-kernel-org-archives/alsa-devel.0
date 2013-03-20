From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcpdm: Collect link
 direction configuration under a struct
Date: Wed, 20 Mar 2013 11:00:38 +0100
Message-ID: <20130320100038.GF28775@opensource.wolfsonmicro.com>
References: <1363772834-29820-1-git-send-email-peter.ujfalusi@ti.com>
 <1363772834-29820-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0723946952455810910=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D39382616E2
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2013 11:00:39 +0100 (CET)
In-Reply-To: <1363772834-29820-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0723946952455810910==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 20, 2013 at 10:47:12AM +0100, Peter Ujfalusi wrote:
> mcpdm_link_config will collect the link direction related configurations like
> channel masks, FIFO threshold.

Applied all, thanks.

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSYi7AAoJELSic+t+oim9PR8QAJHigmyBEdHHMUslfkEg2DF+
X1eaaGQGtEsxx5PdFhKNt3fzutU3uUeXPaAaLkCWd66WXsIsUcM3S2HYkaLeJXQ+
STPeLBznC2omGP8xsHOC3aA5Oi1hat0wjl2qwQPD3f+D66TFiieMOpkl22OAz/Jc
D30iX4+XYtXy/FmzPx2ecEsVgdT1Xdn7kpROkRI7M+0fioXXgHO3etsJEeH3UNE0
P8o6i9zNoXGFeaUiXo4yYu089HVg+VOAFlF8Z2ToiJV8deb6Pg29QZKNB45RJ7Gn
+60YDfp3zei/EiOiMMtFLS4+J5F8GOF0s5JIz04xoH1QgGnI8/+fqzFR/nOoITB4
xfPsetXNqY5GwE79RfQMvgxqMCzc47xjGVIOxiR/DC5lOBKRovJHj4CeUVkK2iRc
NNhuElNohaRJfrjtvzvWZMGQcMCFWncJb7f09R0XGxzoAVgmLQw4CyT2rMF727KY
ftM1+7MXsV5mLTw1cRHqRgGopc+6KPENGPCCYZ+1tP7BO5REFp7D4yykwDuTrlt1
VmKwxRbu99SpU+SusSQz47LGFcYA4DM+7tNg8+Yj22NE5cB0w4LF7IPT06JRTvA3
BtCK6XWlVRsLN5PUM6QnZuEyyw09x4Y2AscAcj5057hzsFYCnvdy77KHF54yoAP3
FAvw0DPE5K4ntHwc0za4
=jzqb
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--

--===============0723946952455810910==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0723946952455810910==--
