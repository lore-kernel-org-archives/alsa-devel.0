From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Correct interface
 register 2 variable name
Date: Mon, 1 Sep 2014 10:54:06 +0100
Message-ID: <20140901095406.GJ29327@sirena.org.uk>
References: <1409564797-15782-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5125469122022571439=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 134CE2616CB
 for <alsa-devel@alsa-project.org>; Mon,  1 Sep 2014 11:54:22 +0200 (CEST)
In-Reply-To: <1409564797-15782-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org


--===============5125469122022571439==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3qYtBtpdm1/OJWPn"
Content-Disposition: inline


--3qYtBtpdm1/OJWPn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 01, 2014 at 12:46:37PM +0300, Peter Ujfalusi wrote:
> Rename iface_reg3 to iface_reg2 since this variable is actually used for
> interface register 2.

Applied, thanks.

--3qYtBtpdm1/OJWPn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBEIuAAoJELSic+t+oim9EywP/1WiJ25ZRTYTv6dl4xAh1Jj3
GO9DeFRmafhY53RX9JgIx+FLH0861a2gpeoxX08MADRIC/3qQ6C7W25Dh0Whx90L
CvqZArxWR/VWI0f5Kf86vrBGR1LpRBuomVMmjxhAU1vWM6iBnvG9Z4CoKmYiZFEE
RLmsdUJYolMcS6US6ercVwF1Rm9ZPPXwyQprFr6XAeoycvr6vUYF8EouhuCzNvwm
kRZrY1YRfQ5idJXmGgAjRfYsXmjsLpdHpE41ikGm2oclDIpQiDP6TyVP4AVZGvS1
s6DlhXswNjVjbeF+FS/QOZh3z0Q1ZeJ6m4s66IL6iH2ukNttJavbdB00ltzt1Kr+
DJ4CtRg8jkOA/sLyGvH7afLeJib0aarQzBvvnIRgqqF5jdIfuJ2WTW4N6K79KMH2
cw0kzimcgNWd2+6tzayFoxoK/0hXu5Yej/bcNYNDYJzIraCtW4u/3bUFWXsn6Cze
GjrM5DwwKLZOr4tjiPgB+pPevoh9PdTsrkAV+v7rvOEBijBolAWFuXiwdSrcAflm
Mr768QV2Q4Ftg0QySz94aO3OcMJAbJNKtlzmfOxmj6PGWV5nC8k6QNTrBpJqb4vI
WW3vYDSaGnja4LoKH9q6LDiPDkMbPZ66a+ES4qDoRLLn4wmKCg0P3GifPFOaeB/U
kkYTdQsVdkhYyB2ARzZy
=8nvo
-----END PGP SIGNATURE-----

--3qYtBtpdm1/OJWPn--

--===============5125469122022571439==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5125469122022571439==--
