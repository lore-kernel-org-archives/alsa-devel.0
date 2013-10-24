From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: kirkwood: add S/PDIF support
Date: Thu, 24 Oct 2013 12:06:30 +0100
Message-ID: <20131024110630.GB18506@sirena.org.uk>
References: <20131021105049.58721da9@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5071122194613852448=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8B106260863
 for <alsa-devel@alsa-project.org>; Thu, 24 Oct 2013 13:06:41 +0200 (CEST)
In-Reply-To: <20131021105049.58721da9@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Liam Girdwood <lgirdwood@gmail.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5071122194613852448==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 21, 2013 at 10:50:49AM +0200, Jean-Francois Moine wrote:
> This patch adds S/PDIF input/output for mvebu DT boards.

Applied, thanks (this is actually your v3, you forgot to update the
subject line).

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSaP8zAAoJELSic+t+oim9x4QP/iF1gtowpbvJY6Dp9NBaA+Li
Vt7TurWwYutiC776vmSHBqL2yC2UGEwEAP44MXa8pNX0G7wdbxjeHIN24LvWzIOm
ic4TUKLkfr/8sgD4DyLbJwhEitw2IgOvLbJysKodWLMsDvYUjISgYOurRMyva4uE
4nQsrdCFHBcwMTWhdF8B4IDKa7z/qrcRjr5bsvob8/0Z2dfqy7MsY4pBgE5VsaZF
yVBFSUv5fUFScVydjQW4bPPCZYvgQDH226Yy/8oEsozJ80pv+Qi9O+o3j+ZtDyfh
T1M8MYeIeQ57vIvW0/8p77QQATLpTlQCxZcuG5Y/kFIpa0pTsRcBYypiolwmQPx3
90st3uZBqC794vGTXQbWrbl5glOsfT97MpOKaItihjbtipxbhj4y65YEznCpbot4
I0vZvyP7QPqHeAT9jjlqtNM2H0nei/5xm54VoXhYqOlUNS44AunuVvCjOWU86zG2
/Ic564i9F4KJ9E8vuAr8NujfZ+l/AFBicw5YY/MtedT+4TiOUqHA7kpMhqGamSqe
Wr+T1xaLI/VXndf4x0Wq4QuYt+i140oL7DWkT2Qeat1zOOXI/foR8NHKpxuylt4m
dpCYO6nNR5mOjnRY15Fi6uZzAxyN6hUDa1zBJCHIVM6YeoBtr+CX0k6a9l7cDbIZ
oRKG1Gt/0zgQg2Yb566E
=IuoK
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--

--===============5071122194613852448==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5071122194613852448==--
