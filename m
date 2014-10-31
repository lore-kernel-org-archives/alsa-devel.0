From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Add jack detection for
	Broadwell
Date: Fri, 31 Oct 2014 16:59:51 +0000
Message-ID: <20141031165951.GF18557@sirena.org.uk>
References: <1414674983-7459-1-git-send-email-yang.jie@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4052203756720065343=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EBC372606DC
 for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2014 18:00:12 +0100 (CET)
In-Reply-To: <1414674983-7459-1-git-send-email-yang.jie@intel.com>
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


--===============4052203756720065343==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vpXrFJ8GtvOCTzbW"
Content-Disposition: inline


--vpXrFJ8GtvOCTzbW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2014 at 09:16:23PM +0800, Jie Yang wrote:
> Add jack dectection and event reporting for Broadwell. It use combo
> jack on BDW platform, which including Mic Jack pin and Headphone
> jack pin.

Applied, thanks.

--vpXrFJ8GtvOCTzbW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUU8AGAAoJECTWi3JdVIfQEyYH/1zCDOgziO86qbReB5A8f3JW
jZnLdQWhil+Eg4Z7gl+tcfGH4Na0uYz+U3uhUj2PHdtW+7mgYbReW0PqHL+7Pbqm
c6P4FJNBl1S/8MAOnka0s0W5c5+UnUgIpKbaCJi3CJrcMQf3Exu+NsaalI2eW1Ww
2rbFE4U7ySKrc6QShzRQ6tC4ZVrAfAJxCwsa+HRDq8B268ScJ8Nr0OlXJi0S6P++
ZAVjTzOtl089UYt7SSTE/PWsRAjGiJYK6kptXcLeBRIPUncFxRaEYhiA29/ZLv1h
wMFewKo1s2PccjrNyHpG71nUC+bZv2Iu1mvbdcpMt1eIBdHkMEf0jCDfS6w0cn4=
=0gM5
-----END PGP SIGNATURE-----

--vpXrFJ8GtvOCTzbW--

--===============4052203756720065343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4052203756720065343==--
