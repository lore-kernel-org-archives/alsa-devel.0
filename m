From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Support for combined
 tx/rx interrupt line
Date: Tue, 30 Dec 2014 16:44:17 +0000
Message-ID: <20141230164417.GH17800@sirena.org.uk>
References: <1419948632-18352-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1066821284760827783=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6268F260679
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 17:44:38 +0100 (CET)
In-Reply-To: <1419948632-18352-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org


--===============1066821284760827783==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MJDoj6C08NHMgYyA"
Content-Disposition: inline


--MJDoj6C08NHMgYyA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 30, 2014 at 04:10:32PM +0200, Peter Ujfalusi wrote:
> Some SoC, like da850/OMAP-L138 uses one common interrupt request for TX/RX
> events.

Applied, thanks.

--MJDoj6C08NHMgYyA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUotZgAAoJECTWi3JdVIfQoyQH/1TWSeMLO5K3r1CqUkNGsoqg
0kfJ1INH8cjWg4M7mEUzmyuGcxlINsi7xphOZMYy50WAdtyUETG5w0XBxpTZGvzS
oNMtraU2ZYxAoZBp3xn+dm9bmrSik/C4hGt/bRGVP3yyXNwESucU4aCNCMsmUaPg
E/UFhzMumeEgsV7oJUlIxdPpO+0+il4ZjrS927ZIMFZle5seV5cAji83d8EbpOq1
s5LM/pIK8flMC3zkUpU+vEC9Cfe3iHS+2KLi2IiTpeG/T/2qJW6PfVu/jE5mIUF6
T7G5oUqA5l8wNog2D8AYTBbrISPnS01swb1A4loFNSTmjzJciT9oh6YJiJfWr5A=
=QV1J
-----END PGP SIGNATURE-----

--MJDoj6C08NHMgYyA--

--===============1066821284760827783==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1066821284760827783==--
