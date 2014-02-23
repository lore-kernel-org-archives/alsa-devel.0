From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 070/102] ASoC: tlv320aic23: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:57:54 +0900
Message-ID: <20140223025754.GK25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-43-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7197162920870153459=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32C98261606
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:58:11 +0100 (CET)
In-Reply-To: <1392723517-12772-43-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7197162920870153459==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SpYKH75o2aPywVKk"
Content-Disposition: inline


--SpYKH75o2aPywVKk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:26PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--SpYKH75o2aPywVKk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWOvAAoJELSic+t+oim9yv4P/0FwM2fmmdne+0US/4mH3r/q
4eyHrvXXEfZhzpMSCKucItVl3HVJvWmUb9qA288yGShaO746w75Y6QGjii1rNNMn
+fMczYOCCNsGq2o0M5lLwUTGakcIi1mhgionFpb0kuYxDqia9D8NDW4UHrb4pETH
DoPAOR8gvyGJIKnV8dtaMbZAtFbinIQze/PQYcrCtdwncyN8LRKS9B98hNDnQ2Tx
mn3cIvot29OUe9Ffgzn4/Kc2Bm7tHpZzpj025Snedt8oLzS2ja1l+teOnZ562nYL
6hjZieuU3WyZflfQwt4Eab6rUOPZCpUfcHtfnKKtKZLbKCLmleVgZOe1K3AZXXIz
LbfkyjZiAVUFceB+9bE0HEb85BM58LlJztQJQZvit8wv1chZTDz44ZMBSJ5qvN1f
ixsiwRF4OH9gchCWuEAhxd7itJxwZYM03PIvdYH5b3CfgYXRUjM2kfZcz31K7Xp1
bExneMd/gw/GPgjn4oU0hPfjIgxnB9Z4k5kuHG3M3+Qcw9Qh1Ea+LNhVBRTrfWdZ
49nlh1mRCw5CLSZj1Zg1ykU1+Qc5/KE0WlyvypvqQk/xVCPRsDfMn49E3OpsUKux
lndVnggrLppfWARXBFAH/fworq1elBjDyGhLqyu1y2PWkzOb19mZ5xpUHQZJbwkD
voGTG8Wk1sx0zi5bihVx
=xLVn
-----END PGP SIGNATURE-----

--SpYKH75o2aPywVKk--

--===============7197162920870153459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7197162920870153459==--
