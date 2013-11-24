From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] ASoC: wm5110: Add basic support for
	ISRCs
Date: Sun, 24 Nov 2013 13:38:05 +0000
Message-ID: <20131124133805.GT14725@sirena.org.uk>
References: <1384877043-5640-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1384877043-5640-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4365648008555719808=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id A3FCD2616FB
 for <alsa-devel@alsa-project.org>; Sun, 24 Nov 2013 14:38:09 +0100 (CET)
In-Reply-To: <1384877043-5640-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, lee.jones@linaro.org
List-Id: alsa-devel@alsa-project.org


--===============4365648008555719808==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5tINJiUS2/Dn5Rhr"
Content-Disposition: inline


--5tINJiUS2/Dn5Rhr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 19, 2013 at 04:04:02PM +0000, Charles Keepax wrote:
> Add support for the ISRCs that matches the current support on the w5102.

Applied, thanks.

--5tINJiUS2/Dn5Rhr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSkgE5AAoJELSic+t+oim9OPAP/3ki0iuu3r6wiijEBTKRO62h
C0KMbP55KjgqtF+ReAO04mngbSrO452GDRDn7tqG1u7CukRwkfhleqrqu/baDWDz
ttOzdnrzz0eUej31zNAaLPP2XLebZHyWe4DX8ETEvA1DTzb95zOvc4OLg0WmLNXr
0AzGH8/oKQQPkJ8aT6g04yZdNN1M3G1jBoTilaDAbu5RdH2dAQGIGGmSNe/qf4h7
WJqljqrDk96z4rjtaEQu4g910TN6lg2N1slJssvdbmD3sM+XvrU5RU69FXbN3yBp
zJcjsIk0FlvNiHsX+9YUmCTX3zpunQb3DSWohaBm2Lt6m6M0SxedVv11jUB409+e
BhInrbAiMDbXa4sKcF8B4TjierYl8D+TjChBlBI7vL9Vn//PCMwkHwj8Dx61GlTj
qPsZjOKKpNrujzpK3AuGoIp1PyNC+cPMgW9GL+McqzwKJ/khuX4igYRzNEjW2FYd
yIoOm+kh8YVAuBjaTV+h0rTxqOS9yYWcu0h3sDr5QWALyjU+5qZn8LmVfGGd2VUc
KU/8gno76g4ygeiGyLbZq2zoI4aO2CjqSDrihP71F/RItRyVrg1NiB4ktqb9YkQX
KPt5a28uY3vmOMr07ZAuhYq7vqlNTBsdU36Aw4UZwouSEACyAH6yl6LIl2LJWkB+
nBGISZ+fEGS0c7wxVgff
=sRsJ
-----END PGP SIGNATURE-----

--5tINJiUS2/Dn5Rhr--

--===============4365648008555719808==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4365648008555719808==--
