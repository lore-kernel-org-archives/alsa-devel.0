From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 034/102] ASoC: da9055: Use
	SOC_ENUM_SINGLE_DECL()
Date: Thu, 20 Feb 2014 11:20:13 +0900
Message-ID: <20140220022013.GM2669@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-7-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5527114877061096031=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6652226565B
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:21:15 +0100 (CET)
In-Reply-To: <1392723517-12772-7-git-send-email-tiwai@suse.de>
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


--===============5527114877061096031==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eD1KVi74e9DkTLEy"
Content-Disposition: inline


--eD1KVi74e9DkTLEy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:50PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--eD1KVi74e9DkTLEy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWZaAAoJELSic+t+oim9ssYP/0e4jGlpnbjbHCVLv2FzB6Gh
vP668KPK9znZmH7NOcrjHcoNQBE6cuv4DUU/O+zJgWmYgMGZ93Ag+ss3mTg5iTGt
gJN93X2EJLDdqObgJerflktk38h9d8J4ieQAcmWlJ9WvcxdEt82xcw/RxXC/J1T1
4UBYiHc9RYNrTj5cgUBSKlq2RDvhJNQqZvcqdLcNpbnhL24Otz5PuqpMHWJaaFRL
K5v7tBW7lN58Yl6TX7XN4Xa2bgD68c2Z0T1Kj9wko8uyyl1MZMEdj6wJyUu99qQf
19CIlU3e65bNMJVyROTVipQd3boON1lAOV5+A9xJFk6kVo8I4gKE0xJta8OZAyNY
iZi4HJI/fLKBecWgPnOOIC5GbfPpeva2mX94PWC4it5MoGmA2UEi4IQZg80QtC2o
P1cHmaOw5vsHlDZ8GrWBXnz28TKm8dtY02CLu3uEkTNU3ceWPuDWk0i7uMBb51FA
5tpA0D6dv29G8W0wUNKM3ok9DboYBLOKUZP+ro/mjGuuxyYq464FHj+dvLHp0BdH
t/kvEGVjr+mjvqktLYmCxDuUaaXXMzXLNuFD4+hQF0T8WdzpS0Nic+BRtXEC/Uj1
VnphkpMJ4xaEk0t5zUvOod4cp8jSosQ0/h3uj8Tev2ycSzZNspmx9pimw0xX8ezu
blpj2HW8mp0W7wZ95hmi
=lv0J
-----END PGP SIGNATURE-----

--eD1KVi74e9DkTLEy--

--===============5527114877061096031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5527114877061096031==--
