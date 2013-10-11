From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rcar: add ID check on rsnd_dai_get()
Date: Fri, 11 Oct 2013 19:53:18 +0100
Message-ID: <20131011185318.GH2443@sirena.org.uk>
References: <871u3s1e0v.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2394911322287645329=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 93C70261A4B
 for <alsa-devel@alsa-project.org>; Fri, 11 Oct 2013 20:53:41 +0200 (CEST)
In-Reply-To: <871u3s1e0v.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2394911322287645329==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JI+G0+mN8WmwPnOn"
Content-Disposition: inline


--JI+G0+mN8WmwPnOn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 11, 2013 at 12:07:48AM -0700, Kuninori Morimoto wrote:
> checking id in rsnd_dai_get() is good idea

Applied, thanks.

--JI+G0+mN8WmwPnOn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSWEkbAAoJELSic+t+oim9Si8P/A++R5jOCHXEjAuG8JpfjXoz
7TjdQDuTTtx+TdpYLxvdL/DGMu1gyHzUEOOsv/YZt5PBMMH5ThCCC5zj0Mi34GAF
U+izd3RLIqgjtlpxQv9mBm11tXecq0MrMGywiFd7aCHwSIKSMrMR61nxhj/evUeL
JADSSMIOGpRdKYCt4Lh3aZGSGn2j6Nbh2DZwImaZkao2bO0ATN+rjrZ3pF+p2RXD
Xi1HcJau9xwcLulO2A7aCtq/ysEZ7jjCHQX/5cEp02G5Z5o+0VdgcRALufLNRVWo
lwK3cDDarJMbMylBSS1iSj1ZXaXkKJvDWglmPWm8DZ/Oiux2xl0FM6FG1ffNfI/G
ASNevn7G1WF7O2s7XFDB4UmQqqGveJNK2wLh2JMOgLwttUnMiI+iutWB9wL/YoM5
BAunhzhi722r0LRSB5+M8EA9MThHd57BCuWL6Cwbl9ZELAEF1rhjF8UAWPEnTv14
oOJCh4pjkF0Aul9QNAZsKxaibcXSpv0ZSbaSSWEQ5HykOR+1hvkcbqRqmOnLg6GU
avKsn+74qR+plvkVY2wuez28e7+3TcSB+TY6M2FfpHZGZ3v5rlyqyOzGk/rgeDOL
L5pYMKq/4NcEKsHvVVySkqVqKFmepQVgRLVFOQW0fA78/7Ywf4iHRQGjC73w2Ovk
lZBCds/qYcDl3CgdzHdI
=MKmz
-----END PGP SIGNATURE-----

--JI+G0+mN8WmwPnOn--

--===============2394911322287645329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2394911322287645329==--
