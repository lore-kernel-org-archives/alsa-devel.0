From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: simple-card: use struct device
 pointer for dev_xxx()
Date: Thu, 27 Dec 2012 16:51:31 +0000
Message-ID: <20121227165131.GF5005@opensource.wolfsonmicro.com>
References: <87zk11487a.wl%kuninori.morimoto.gx@renesas.com>
 <87wqw5485u.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3227366342071922062=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DC72A264EBF
 for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2012 17:51:32 +0100 (CET)
In-Reply-To: <87wqw5485u.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lrg@ti.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org


--===============3227366342071922062==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="t4apE7yKrX2dGgJC"
Content-Disposition: inline


--t4apE7yKrX2dGgJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 25, 2012 at 10:52:33PM -0800, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Applied, thanks.

--t4apE7yKrX2dGgJC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ3HyMAAoJELSic+t+oim9RiUP+gIpntYa156TKqrD+8mkfpmB
OSOgTNsN3z+Gj9hw+Y8JTuYgt5qxlc0YClhFzHU7PEL2A0Cp7QnablVsoX763pOx
EG2vLweQAgUaybHhVuMaqBkhfHlWhCecIpiqoFY2NzqQVWliWg3PD6qkNFSWIP7J
lejLPhaeJ2P8V5X622vuni6jODVKiwkIwbWtR73ZTJysbAzlOxGmde+vjmeFMIzh
lx/BTKTtWPxz5Eoz4vuOpuLF8dqeI4YT8O7URNvL+mEkrl34yWci9MK/MX8BDzry
giM6B3FpA9OmTi3EnatdhoNktMMHhqP/X8l2ffkAMBWXH0np9q7e4j/D03eN1Mt7
ShALbX6HElZmCgpKYw9m2FLxxTYE4d9twvuu3Mbivj3sJ2KEyogj0/htLFOB3JJ4
VHQW8TWOqsb8NZ9OlJ+NrCmY9q5nyfWzhD+cR4Q0qMrpZFVxhRMfWJqKPteJcAHl
TblB17VgO8dG3LP4GmvnGfRrUNzKzqomfuY7X0XVrx/FB7hyCoSlEi0GmfyxSLyK
4mMAYcGjxeIjL6bQhIeQFf0sjR0IuRzpPl5rE356ZXJgGflDI+4tw79JmMzMyzBE
K5wB+vthzSdr/3NmJ2mNdEMFHWMQuTJOTk2k8ZlNN7Nxoqv7VnIywIdPh+uIBKzr
8rNh3mCdn3XMSMSh9m4c
=a869
-----END PGP SIGNATURE-----

--t4apE7yKrX2dGgJC--

--===============3227366342071922062==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3227366342071922062==--
