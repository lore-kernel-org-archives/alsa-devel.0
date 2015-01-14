From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5677: Use the regmap functions
 instead of the snd_soc functions
Date: Wed, 14 Jan 2015 17:20:03 +0000
Message-ID: <20150114172003.GZ4160@sirena.org.uk>
References: <1421118795-23092-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8184610547135118727=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BEADB26066B
 for <alsa-devel@alsa-project.org>; Wed, 14 Jan 2015 18:20:09 +0100 (CET)
In-Reply-To: <1421118795-23092-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, yang.a.fang@intel.com, lgirdwood@gmail.com, john.lin@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8184610547135118727==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XsxFkDPDWfsXVt/M"
Content-Disposition: inline


--XsxFkDPDWfsXVt/M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 13, 2015 at 11:13:14AM +0800, Oder Chiou wrote:
> The patch uses the regmap functions instead of the snd_soc functions in some
> cases.

Applied both, thanks.

--XsxFkDPDWfsXVt/M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUtqVDAAoJECTWi3JdVIfQxlAH/2zSxCXWpUUFhdUkhsBx851d
2PsEcbTs4ZjRv5fx/zfu6VQLtOBmvgOpEhJ+wxfvLy86UVtebLiactCdZKuRgDK+
0eX+/5cwRVKze2TUh5rI37UQ4QurxMLbKSRzXSWRdbTAQM7VMcnq7s3t6mRnlJAJ
RzxiSJUbBF/P/rOKoH7RnIxg7kM/ss7ZRN5Uoi5Fd0Fw8IISl9yAPMb803Ew+STq
lYIXV6frdrKZEXqhQSNQ1cCsxeEZk4Xdf2cD8z16iCw+FdU6U2BuRqyj/HawnPgg
kyYn4Baa5dfjesbl3py7agHUTDmIQz+vokRtJULE2lwgiQyyE/OXyRB9azLavJo=
=wwoa
-----END PGP SIGNATURE-----

--XsxFkDPDWfsXVt/M--

--===============8184610547135118727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8184610547135118727==--
