From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: arizona: Correct AEC loopback
	enable
Date: Wed, 5 Jun 2013 15:46:51 +0100
Message-ID: <20130605144651.GE31367@sirena.org.uk>
References: <1370440291-2876-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8666948222280729160=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C926A2654A8
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 16:46:54 +0200 (CEST)
In-Reply-To: <1370440291-2876-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8666948222280729160==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kgkihKxW3Un7xdgA"
Content-Disposition: inline


--kgkihKxW3Un7xdgA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2013 at 02:51:30PM +0100, Charles Keepax wrote:
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Applied both, thanks (though like I say the second patch should have no
practical effect - if it does you're probably missing something else
somewhere).

--kgkihKxW3Un7xdgA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRr09YAAoJELSic+t+oim9fk4P/3ij7ZxsP4tlI/Hg0cTbSjPJ
LgNy4LYdbvP3pMs6kb8CPmjM2c0CJXyk2q3wJkpMwH2bahea6lerWEZ2Nr5OrT5u
iQkBEyhn5sOsjFDl5mY7JDjxn5VzKIXBOh4bJw1eptgdJUmzSadTT0VCKH3vDDBM
Mej9eKaNW/peAZ2FuxiuoZslhWXDdBLF+0+A/fEoBWZK7dSOLIDSpjrEZjg3Lepk
eQTGQIs7oQ94V+y8amBZuRusShDB9Bgt1bYjhZvaRiL+Bgn5UXh0LErTvNMYfHC1
8NBDR4i12b6Im54wje0OpHz0wvuA1l0VP0J1LLZXoaPLTzAYxW3wnTnno201ssS/
uUnB80M9kUvtghXDv0VCMsoTySRr2wBCamxGvxeW2PyshOGgmXlvYCBIoJHYyaay
IPxj0rzCaB9j8vtSKVBYP5I7PIIKuKk14IXjmii5LPKwz2heehq3j+mVp5JRP9bc
Xh1Y0QlUeqroRPnWEAjG9dOAov8BjSqMkaVTU/IWroSPnOBaI6qQmdl+hMUImc7T
+3xVlvUszEIYo9o5LRDPFpR2sbJlumHwgiFkY+T7uWNksqMwyDOGsfEf02BzGQaa
1SuQnnOzaya5lAvIS45FHfLiS8myadcckbnQkb3oMQ5EM1EGa3AoVR+lxD3O+Zg5
9IAHF3v1P92c2GNOPxA/
=RcOF
-----END PGP SIGNATURE-----

--kgkihKxW3Un7xdgA--

--===============8666948222280729160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8666948222280729160==--
