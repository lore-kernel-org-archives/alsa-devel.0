From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH 1/1] ASoC: dwc: correct irq clear method
Date: Thu, 1 Oct 2015 11:03:30 +0100
Message-ID: <20151001100330.GA12635@sirena.org.uk>
References: <006301d0fac4$94eb5890$bec209b0$@tangramtek.com>
 <20150930181751.GT15635@sirena.org.uk>
 <00fe01d0fbf2$5a73cba0$0f5b62e0$@tangramtek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00fe01d0fbf2$5a73cba0$0f5b62e0$@tangramtek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yitian <yitian.bu@tangramtek.com>
Cc: alsa-devel@alsa-project.org, wsa@the-dreams.de, linux-kernel@vger.kernel.org, Andrew.Jackson@arm.com, tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 01, 2015 at 10:39:09AM +0800, yitian wrote:

> > This doesn't apply against current code, please check and resend.

> I synced up to latest kernel branch, the code is the same as what this patch
> was
> generated.

The "latest kernel branch" was neither v4.3-rc1 nor my for-next
branch, at least as far as git am was concerned, so I couldn't apply the
patch.

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDQTyAAoJECTWi3JdVIfQNsAH+weQgGpmrbApzpzx62qjjWbX
AJd15IQ8DeSAiuGDeMRFdb8J+Oi2LwNqWGFEpBqRSyN0TLnnrOphYI3RHpCE+p6Z
Kf+shBuC8Y+6QEu/4bSFc7EcJif1nDIkxsrziiLB//f7248d8cJNDrTpC6fZyugM
kxoK1TtttpMDGoK7SlOcZqFTY5z06sozhnb1HZ3xJMypzDpwf98bfwXEmxsigZxp
8rXDznJGBQ3rDNDGAvabqM1xSXYILKrSB9I/Kx0WnqGwawJfUB/LuRK3aA7PvqR3
fdD43GynBjnPfGV2fztmTc1PCY3QQcqgYFFWdRhN6GM8F0aLc4yPQYneEpv4gHc=
=2Whv
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
