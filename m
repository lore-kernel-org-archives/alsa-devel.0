From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Fix snd_soc_dapm_put_volsw()
 connect
Date: Sat, 30 Jun 2012 12:39:50 +0100
Message-ID: <20120630113949.GT28922@opensource.wolfsonmicro.com>
References: <2026346.354826.1340996989713.JavaMail.root@advansee.com>
	<2127566796.356487.1341001087854.JavaMail.root@advansee.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8917293789341254192=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 880A82461C
	for <alsa-devel@alsa-project.org>;
	Sat, 30 Jun 2012 13:39:52 +0200 (CEST)
In-Reply-To: <2127566796.356487.1341001087854.JavaMail.root@advansee.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============8917293789341254192==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VjP/dwTbBl6I9PQk"
Content-Disposition: inline


--VjP/dwTbBl6I9PQk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2012 at 10:18:07PM +0200, Beno=EEt Th=E9baudeau wrote:

> I've finished. The following patch should be applied after my patch
> "ASoC: dapm: Fix dapm_set_path_status() connect".

Don't submit patches in the middle of discussions, but please bear in
mind what I just said about not doing stereo.

--VjP/dwTbBl6I9PQk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP7uV5AAoJEBus8iNuMP3d3nAQAJA6y96hMckt4WhQjJ7yjNnH
WsTscWfaXQRbtUpSrvIhA0UHlFLlP03Nfv9jmLV5hz2zaHxFTZF3aXXlB6XqrZie
dRxvQU3DRkY75SCoIre3KYywQ64eGbQUFMb0BOxT5zXBMchq86aGx6ttH1oUHZoi
PwK3Pql68G/cpaWQcVHkYcq5tR8wQr2ElKCUSE3fqJ2Qe9uOW9tgrai+wvN9gBoM
4mRS7EzjebpuaovmQgh0mgAoSzqYObM5S6+ypWZynKMKypjC9OKVixdnqrQ1pQEC
U1viQYHz+QT7kW5kCSo1OyrUJZV+PhUWPsU1+VzniPdReiXfWGL587ytZKQgd6FL
8iJ4f9mLd6IXIueJnWbJ+oWfI2I9pNQdMsxcLf870WElKJHlPzw22ZEj0slQMw0q
l0ZcZ4XzPfzTjscr67hHig7VFUjwq8F+636kVedvRjHqr4EcH/Bh9ov+jB8w2SiV
s9vFG6zl9lIvfVYlqfL6HbNeaj/ZJhBNfmGg6VTrgCTK4aOOKWL9FIbOQZpAZeVC
hwyoOZ5mrkDLGBQSH6sCM21P1KYglntcQkFe7NkHU/xOaqMHav7OpF6nzUXLusi5
qnD5hXIg3+CdcdPGvNNhlURnyVbL/C0GgQcYAgH0CK8yBbbVBhPzn7eduxgXuaJD
WfrngHc3RWSXhssgIZEV
=YEAf
-----END PGP SIGNATURE-----

--VjP/dwTbBl6I9PQk--

--===============8917293789341254192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8917293789341254192==--
