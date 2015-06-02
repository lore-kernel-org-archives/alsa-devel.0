From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: qcom: Remove QCOM dependency from LPASS variants
Date: Tue, 2 Jun 2015 11:55:19 +0100
Message-ID: <20150602105519.GL14071@sirena.org.uk>
References: <1433221532-9489-1-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K4LMwn8CgX2KMboP"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433221532-9489-1-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Jim Davis <jim.epost@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, Kumar Gala <galak@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--K4LMwn8CgX2KMboP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 01, 2015 at 10:05:32PM -0700, Kenneth Westfield wrote:

> Remove the dependency on SND_SOC_QCOM from the user-
> invisible LPASS variant options.  This will fix
> randconfig build errors.

I can't tell from this commit message what the patch is supposed to do -
what are the bugs and in what way will this fix them?

--K4LMwn8CgX2KMboP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbYuWAAoJECTWi3JdVIfQb6kH/iBZwWg5E7ibUM03u+zoL4KH
KpuLNZwSBh6AS6rk8T/Qn7oZ3Xx1ml7apqy/lLWgtFkinTbsOa3GIV/fzb5an0L3
WM9ARuPxjOIGYiQd3/ollqS+7MwWh+oC77KBlLOP7040YHTnYHvTVgcOhCxx5vQr
jwcQEpICq/ASGam+pZ8iFaQUdVE/BGAD46w7ldrdBY+rs8kkmZvArGTqEwcKgXY/
eJWY9dx86WpLe1dwKfLwwVrBka4goYjccFVKmoXOpiTeaR8hhTuwt0VkrF4aaa2S
dn6MWWLq2CMnDgCNu4lXYOTVciVLlRSlNezI/Rf43L8Qe/qyZN/27YSggOrf8ts=
=XPp6
-----END PGP SIGNATURE-----

--K4LMwn8CgX2KMboP--
