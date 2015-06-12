From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt286: Add RL6347A class device
 shared support for RT286
Date: Fri, 12 Jun 2015 11:19:06 +0100
Message-ID: <20150612101906.GA1921@sirena.org.uk>
References: <1434099989-18305-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2240987042774400318=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA9F6266887
 for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2015 12:19:25 +0200 (CEST)
In-Reply-To: <1434099989-18305-1-git-send-email-oder_chiou@realtek.com>
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
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com, john.lin@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2240987042774400318==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2015 at 05:06:29PM +0800, Oder Chiou wrote:
> The patch separates the IO function from the rt286. It is prepared to share
> for new chips that support the same IO function.

Applied, thanks.

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVerIZAAoJECTWi3JdVIfQSHAH/2odABNBRYwdepfuztJcp0ly
rLFTG5xyccwYUHv3B2gZdTZGg6xx4UOIaEZS6eX3Q7tG6asiYd7+F5Z4p0e8q+sj
FOc3B14sWxLPKl9dbA+k+0nnBd2UDts1iHgBnrKUcikgW2RBf8rOvT/jeuCS6MYB
9vfyP2b5ul930B4+SpC/PDDfXlP1KcEsjXR10CYfi2XZscoYu28s7AnN1bqaDFAV
sTYDdqPonODuDDDAmWbL4FIX7DgyTho842v15w1XLwOj5iKaUKlIhob9H2HcCNvo
u3WUCYkSBV6UzR2gkoNWps5+xnnlVohXk/wTR0gcEhNzM3yJnR2BhhrzaD8kVSU=
=Fj3Q
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--

--===============2240987042774400318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2240987042774400318==--
