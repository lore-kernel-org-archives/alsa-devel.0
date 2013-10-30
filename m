From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/9] ASoC: wm_hubs: Add missing break in
	hp_supply_event()
Date: Wed, 30 Oct 2013 09:35:39 -0700
Message-ID: <20131030163539.GE2493@sirena.org.uk>
References: <1383118507-21503-1-git-send-email-tiwai@suse.de>
 <1383118507-21503-5-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2134664779215603251=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id C6ED9265532
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 18:09:50 +0100 (CET)
In-Reply-To: <1383118507-21503-5-git-send-email-tiwai@suse.de>
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


--===============2134664779215603251==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="imjhCm/Pyz7Rq5F2"
Content-Disposition: inline


--imjhCm/Pyz7Rq5F2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2013 at 08:35:02AM +0100, Takashi Iwai wrote:
> Spotted by coverity CID 115170.

Applied, thanks.

--imjhCm/Pyz7Rq5F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScTVYAAoJELSic+t+oim9EegP/A5Sgc0VcnWTTxky0/1Qkk6u
IEarrSvl0rA1/tyA8ocTBXUE4udDNTeFwW7HuttMf3fjZnbhbOmsAbPydIjo92RW
MIR6aaZbdXnrUGrEc+SXXVn5bmT6W7E0ZhFXtjE6VAmKHxzsBjbXNhWdlwy3Q009
/yjmDmIuxmuXmjO0iv5Wflwe4cjvW/Lg2Zr8o7yvrCwGDuNfX2vqRfU4tHuoFiUo
Nodwf9BQPPMuryA1QNw7xLSQhfHEUcFIJFIgWp7DDJbXyDjDU3ZEVD5tLFX4pOp5
vd3MisqJ4vuO7IC3b4R/O6LgLdQUSRxSq3z1KeN3S2Vslir1LX5Wvd88+Yd+j4QO
+haD2+YM6NXq8jlB87XDm5FnN2xdB0+BOomHDn+Iq2cAYo5l3hrIx/jzNfvoI+y/
xmruA5roppM8VbxRCq9ezFo4N2PndY3rpUSl2vl6H/JAzFB7i4ZrVkgTFO/jvhRO
/nfvLntkdIQ7MJsEfcKRrdJKZ+CgQ5hQ9WNFDT3/0kKCyyE0kTGBTH/OtGd2jAHI
sVC38+wmIti7byelNNILr9efnsG2extMVJU4/LMvvas+KcGHDJw0eVC5GA+W48gg
rRXdJprso0m9QhHcjbrZ3n6ubaSmF+kuwB5h5KIKVIPfqBYzCQY4rgXNoUdOq+pb
yyTYYUpwTbSFbJz9U8Po
=oz1n
-----END PGP SIGNATURE-----

--imjhCm/Pyz7Rq5F2--

--===============2134664779215603251==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2134664779215603251==--
