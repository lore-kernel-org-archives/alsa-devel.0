From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v1 0/1] A misjudgement should be fixed
Date: Tue, 25 Aug 2015 17:33:04 +0100
Message-ID: <20150825163304.GC12878@sirena.org.uk>
References: <1440489162-28270-1-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1440489162-28270-1-git-send-email-zhengxing@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xing Zheng <zhengxing@rock-chips.com>
Cc: dgreid@chromium.org, dianders@chromium.org, heiko@sntech.de, sonnyrao@chromium.org, linux-rockchip@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2015 at 03:52:41PM +0800, Xing Zheng wrote:
>=20
> Hi,
> Being careless, judge the return value of snd_soc_card_jack_new
> is opposite, so it should be fixed.

Please don't send cover letters for single patches, if there is anything
useful it should either be in the changelog or after the --- in the
patch.

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3Ji/AAoJECTWi3JdVIfQtXwH/jmiEd/YFkh1bjoGQDnHZyOL
F+K6m3BCcpbU9bI1cJ6oQGb4gTRNFXYCmqKhT+w2+q7bghsBtZg4VCd6DuSExa54
gtxksZns3ZD4LXCSCHRrIx3A/LgOH0f+WKVuUgmVjovXE8QNyjSc9w1xubF9rGwk
M36bLNclYUi2XSAGW33Q3Jsi4K2QsRDV2GXrqjyvKau46EsWh0H5MIh5XKFzPqH1
HBf+5Rpl7HAzNR79K93a9xCNZgesEmzM84CHP53zRfA1fXW2tg1Myj0nhBBF2YVF
TIGd82pCKLqZKq1SPAONn5QAOiYmE06Z85SVRue6xbI+O5Qsjwnnp+YhlFTALUU=
=qsWF
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
