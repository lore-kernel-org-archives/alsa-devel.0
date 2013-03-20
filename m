From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: spear_pcm: Update to new
	pcm_new() API
Date: Wed, 20 Mar 2013 11:03:30 +0100
Message-ID: <20130320100329.GG28775@opensource.wolfsonmicro.com>
References: <1363629444-22082-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8679671457924330932=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5F7092616E2
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2013 11:03:36 +0100 (CET)
In-Reply-To: <1363629444-22082-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Rajeev Kumar <rajeev-dlh.kumar@st.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============8679671457924330932==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2013 at 06:57:23PM +0100, Lars-Peter Clausen wrote:
> Commit 552d1ef6 ("ASoC: core - Optimise and refactor pcm_new() to pass only
> rtd") updated the pcm_new() callback to take the rtd as the only parameter. The

Applied both, thanks.

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRSYlqAAoJELSic+t+oim92akP/1I/XMtRwsZrQdrLl1YMEGxI
lUsIklI/2X30gnERdTh5joDHw9OrAJSpR1v8q9mwLK/qFjJxvNaLvdNofT1dgJMl
xHlFdE/3oJngb4Qo2tc8sJnsehdV3Rnai9rV5r++jSmPcpw6AB2aDNYJJaCyqusK
aFiTnNUp6Fh8Kw33/f9zsnxc9SILbfA/qEnvURRwK4xTOkpm/c7FXIyDzitG92aN
GqPzA4P6WvPN26XRZftPtoz6wxGCMdWBN/TtAgZXioO0dlOZG33Q9N/+mPg61eH1
NyWPqkzMeYNeRfvQQpwRiWXSKDWsbLxgaYjga4mX5QEZUg6JDll1Fzfdtirv7zKA
LCjQV0lHcuZNESuJmoobKeM5vYSXOyMpw7tK3oeJv8iWRMTwI43K3hjwbvoeSZGQ
S0lLNxesmRmvgrOwO2bW62NsO2cmYi+8nXNGqIRdPy3h5VJ0upNemDFk+lfa7Aj2
zYjeTtJQfFgB04tZbcEfyqPP69UCPWsn5bx0L2ctz+ToIdy8vUN1NMVjrBfb/+wV
0RRu/8A/UlJ3EZYfWy2SiLO63ael4Dn27KDH3/Kyqb54zs6KuZnEm7h/3Tr0ZJNV
CW0z9pg5Q7HwJn3I/G27hPMC0bPn5UhXEk+ZTeHXLlaC49gdQK1n6hMs8oxGGZdH
u61Q6zuwyXzl4svjgp2d
=zGNd
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--

--===============8679671457924330932==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8679671457924330932==--
