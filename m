From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1] ASOC:DAPM: extend dapm kcontrol to
 support runtime route update
Date: Fri, 13 Dec 2013 11:16:27 +0000
Message-ID: <20131213111627.GV11044@sirena.org.uk>
References: <1386933607-828-1-git-send-email-nhcao@marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7189155956241855149=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F5F3261603
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 12:16:32 +0100 (CET)
In-Reply-To: <1386933607-828-1-git-send-email-nhcao@marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nenghua Cao <nhcao@marvell.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Henry zhao <xzhao10@marvell.com>, Yacine Belkadi <yacine.belkadi.1@gmail.com>, cxie4@marvell.com
List-Id: alsa-devel@alsa-project.org


--===============7189155956241855149==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="50RDeE14MEV4qpyy"
Content-Disposition: inline


--50RDeE14MEV4qpyy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2013 at 07:20:06PM +0800, Nenghua Cao wrote:
> From: Nenghua Cao <nhcao@marvell.com>
>=20
> V1 -> V0:
>=20
>      refined patch, and add flag into soc_mixer_control and soc_enum=20
> instead of the alsa core, according to Takashi's suggestion.

I don't see an actual patch in this mail?  Please also try to use
subject lines matching the subsystem standards (ASoC: dapm: here).

--50RDeE14MEV4qpyy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSquyHAAoJELSic+t+oim9UKoP/jBOa8I2L7v0CPSbo51eQYYM
LIdanKfuBuRlATtR+4SNVqGi1tJULALVXiZVRv8dVXvxgthrUg69UiblpSeVltxo
Q9pqXWf/PvjDOa3EV25wjqGVxTCdnP0CqLftzcsO3niq8aTabckEOb0JryUzx7JT
5IjgWDfyfnRvy95PcpmouynMvClTVxgLoF+82SJ7EKok+UGo+7UkTBGcSVS3c8wL
XUpQIoGXGaGLTw1mQX6hN03cMu9R1YVuZu4WGF2muohrxiqF3LwiIw0nOT0ySPLS
mmQ6FvUXmXrk7MGVsnMV7ptEghguKI8D2/7Wa60Vici1xG0XtdEH9pdtRD5Siwul
Aruf2nzVHKO5Gt1/2GgoV33DT7ZDxb+lkGXOf29lWRE7KQ8UdkTlmk2BwxFdd/x+
R1uwJuWwY8owfbDnr5bkWXUPhz9VnS6hGE53MXFFBClevtkafPRmeFextwMovD3L
Hiawmb5aF0a/sTX4bIDkpm4+yWZLnAxz44O/ajHoeQhzBK9VKwjHJ5qiMnWsnEPi
uIBxjtReBsk8GDOHgI9POYEqNTxBE/0SAvvRoZKkEOkQe58cjQcAx6fYxn89hXB3
KQEpGAGktHZIODYzlololM5ZvPLfGfoXIvoGor6qDFkogzDJd4yCQhLJOpdd6gGB
M1wqjmdwwIbi+58dSoMk
=T8gD
-----END PGP SIGNATURE-----

--50RDeE14MEV4qpyy--

--===============7189155956241855149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7189155956241855149==--
