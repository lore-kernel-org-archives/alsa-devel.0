From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: pcm: Use wildcard msbits
	constraints
Date: Mon, 29 Dec 2014 18:25:38 +0000
Message-ID: <20141229182538.GG11764@sirena.org.uk>
References: <1419875018-30812-1-git-send-email-lars@metafoo.de>
 <1419875018-30812-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9215818755780352180=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 719562605B0
 for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2014 19:26:01 +0100 (CET)
In-Reply-To: <1419875018-30812-3-git-send-email-lars@metafoo.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9215818755780352180==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Jk3WmgcJCJZxDgNq"
Content-Disposition: inline


--Jk3WmgcJCJZxDgNq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 29, 2014 at 06:43:38PM +0100, Lars-Peter Clausen wrote:
> Use the new wildcard msbits constraints instead of installing a constraint
> for each available sample format width.

Acked-by: Mark Brown <broonie@kernel.org>

--Jk3WmgcJCJZxDgNq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUoZyeAAoJECTWi3JdVIfQc3EH/j/1blNi2DyOaoHY3PJFuAiR
SPEMxXMN2zPyyDMnLVb9vUwOXCdu7Pkgi7JXlwt1mOk7ds/t5HNbYsfr9ozDftKu
mf1R1EkBEYrMLytI/3DiVDP/Dt9r2x3I76jyonrCv38oLxrcUGUnZS6QvhF232cI
uoOaUjrWAPEmAmP53PyQt/O+xBx0y+UTt2JOZYWc57FiHuieYb6OPui3hLxqXZ0n
ZoSFoAtdZwWdc6C7li1oDmlQ6+xkjBN3ZHACszQIuU3X4z2FswGWAmKlTUmmZgDk
fROf6Tg012QEll1axfbzdBMJ3auvRM5sDA9huJhbZePg8PfFRY4hmX8w0dbQIEg=
=hM8k
-----END PGP SIGNATURE-----

--Jk3WmgcJCJZxDgNq--

--===============9215818755780352180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9215818755780352180==--
