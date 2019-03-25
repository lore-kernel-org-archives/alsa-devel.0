From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 02/11] ASoC: tlv320aic32x4: Model PLL in
 CCF
Date: Mon, 25 Mar 2019 11:24:01 +0000
Message-ID: <20190325112401.GB7284@sirena.org.uk>
References: <20190321023854.16947-1-nh6z@nh6z.net>
 <20190321023854.16947-3-nh6z@nh6z.net>
 <20190321151208.GA24351@sirena.org.uk>
 <E298AB4E-9154-4E99-8FA8-22CE3BDBDB9D@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0322138612602475105=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CF874F808F6
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2019 12:24:04 +0100 (CET)
In-Reply-To: <E298AB4E-9154-4E99-8FA8-22CE3BDBDB9D@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, team@nwdigitalradio.com
List-Id: alsa-devel@alsa-project.org


--===============0322138612602475105==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2019 at 09:12:05AM -0700, Annaliese McDermond wrote:

> > This doesn't apply against current code, please check and resend:

> That=E2=80=99s funny.  I just checked and I=E2=80=99m rebased against for=
-next.  The
> patches are generated with git prepare-patch.  They=E2=80=99re applying on
> top of e390c46faf.

$ git show e390c46faf
fatal: ambiguous argument 'e390c46faf': unknown revision or path not in the=
 working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyYulEACgkQJNaLcl1U
h9BIogf/enwB5DCnU6Pq6rencPybHVfykcU7m1H7J1P9lpCNCkpLmEauZ7ANpqeu
tBXA/cNZDpT5XgGQt73g4/9HL/XvmMazeml9Auy315/6servLOHZJlTMPjvQzV4C
e8RdxX5NuZ1kDHTV3AQsbPyPl7cEC7cKtQhXY156NmRsqTUkrDwAR5/bBFw5je/j
V0llYnWG9DQzAtxFh3JtBvviwY+2vUixle9q9V72mPdbaR7q2jhuOKxWkonIbF4o
W5XTOTLXFpU/U5/aDynRjk/0C2vx+jgO1bR3scZZpqaUOQLwJ7ysW6kkgelApnjj
djwyzganyw5hjfNy9lzqmr28K14vsQ==
=+Otb
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--

--===============0322138612602475105==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0322138612602475105==--
