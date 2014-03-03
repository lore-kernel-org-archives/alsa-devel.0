From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 07/19] ASoC: rsnd: tidyup RSND_SSI_xxx flags
Date: Mon, 3 Mar 2014 10:21:27 +0900
Message-ID: <20140303012127.GG2411@sirena.org.uk>
References: <87d2ib90t9.wl%kuninori.morimoto.gx@gmail.com>
 <8738j790ql.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4474879665154313832=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D55F12654DC
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 02:56:57 +0100 (CET)
In-Reply-To: <8738j790ql.wl%kuninori.morimoto.gx@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============4474879665154313832==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3607uds81ZQvwCD0"
Content-Disposition: inline


--3607uds81ZQvwCD0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2014 at 10:15:33PM -0800, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>=20
> 6f3ab6c1c022e7a4877d38940cd45ae7804a15e2
> (ASoC: rsnd: remove pin sync option)
> added unused RSND_SSI_CLK_FROM_ADG flag.
> It should remove RSND_SSI_SYNC.

Applied, thanks.

--3607uds81ZQvwCD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTE9kTAAoJELSic+t+oim9ZXcP/14TXWN238LVr1l2gZxVUihd
lfAEVSS+TD+4ftdvcmhfVXdZm85tzQXs7yTqrLSnorL53ogZdKFJXTzkBPyfJe6A
97BmU1EDR024I6w4nvFTrFInOa+dm2F5PVGWRogQMRNw7sn19EPUEuAukYjBWLJ1
IbB460AIYs6oiOV+uxE/A5XmkKcNsXZBVmVmsRvvfHO8xYYKKrd8dITlccsoGiDW
DiMFDCKNWo9UzGx0T8ecRPRqd7PqKG3t2QyxdpwFqAhMPXoPUww0p5cDBRW/SPpm
BCW6tY+M/tZE6DHJUir7XbN3XtLSw4E1chsSfKMxw3SaRt5GCvQZzAcF2YNZyFzG
Gz0hinbr59hvNAaeX/fpSdRPk0JtEqcx1rPbHLHtW3mJ4E3OCEw7ChMZwYQ1uR2S
AEbIZ/JSfZf+ehdXvzsanmFeaNsOcK3sdTdkyxZrF4ashezH/MDEwVKpsbLHVAMw
PPPwEj6OFVRKoPn7TcMLb9urFhg95p06+DU9Tb2e3pfKDO1/3zSohludCxgZYqko
On5WBXoDwYvO3/3quikfvGj0peboAU1Oi2hAEOzFq6bSi0Y0paWvmq/evFoSBbLr
1hwPAkC0AaMk4nFcdkXjOpdUHuqTLC1CmhTMs24zXSL1GBwFDQr2MHo0/fq6Mg3q
ObTRC2t2+v8TJPLzrdfH
=eaBe
-----END PGP SIGNATURE-----

--3607uds81ZQvwCD0--

--===============4474879665154313832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4474879665154313832==--
