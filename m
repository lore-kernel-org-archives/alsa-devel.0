From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/9] ASoC: sun4i-i2s: Add compatibility with A64 codec I2S
Date: Tue, 5 Dec 2017 09:01:49 +0100
Message-ID: <20171205080149.2siofhpynfrvnoiq@flea.lan>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-3-anarsoul@gmail.com>
 <CAEKpxBmHhZ+2WNXJEPbQFS6KeKsqRrZeNodRnu1M5yLc15DerA@mail.gmail.com>
 <CA+E=qVd+uM0Aq_=sf+fomQ-m+3Oy0MdG7OPjF5tVagG1UgKYzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6266063231941738675=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CA+E=qVd+uM0Aq_=sf+fomQ-m+3Oy0MdG7OPjF5tVagG1UgKYzg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Code Kipper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============6266063231941738675==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gt5czcylmc7sk4zv"
Content-Disposition: inline


--gt5czcylmc7sk4zv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 03, 2017 at 11:34:06PM -0800, Vasily Khoruzhick wrote:
> I'd keep it sun50i_a64_acodec_i2s, since other 3 I2S modules aren't
> compatible with this one, but similar to H3.

Please don't top-post.

What are those differences?
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--gt5czcylmc7sk4zv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlomUmoACgkQ0rTAlCFN
r3STbA//RpPkNFbl826QuUOmmEUO5gdSHdJ81wAh18J2kuncNhxf2up2dJTmJzLA
KnleybDNvT853qc3rOk0TkPioFlF/VlGbbGOllJjDCEwVNEqAcD6mtoEncJ8Ur9P
+cmqWhUA3pnDGleB88uTmLoKnhiUkgkxeq2vncARZwkIvXEX/T7awZ1QyTALE9WE
t5p1fgAeX/LDOzr4p+7ekuKzEtR3uexax6YhDgwN/LkrZ6srbPwKMquHfwGVZDRE
hDg5U8IJMRvHaShkQuvyAJboyaXUtuKkuYnFAq6aTpMQe4qmlhsQCSjXWUn3hqj/
n0aKlggqCgeGAhEPNFV1AsrQ4jcBMq4c2UOfz+akLRdFWPOlmy2hk70ty8/OYPa0
BbREtaNIm3s/bQY04Kx9MWql7I6tiJjUAqArx1O/SIlUozEGM0x+FrZHHTO1RByw
4/QoUDl6pcdSwjp5cWcU39ZAgErtmoXu8IiG3M0Wv4vtELdYAS409GeUWQ9KNsSs
hMxiZTErJoU1iRtkL2fIxniUHR+YiuhupnR9uLEn/Dtv4PZuOM+sTCmZyWGM5JqG
gWgix39GUXVDCHIW2m5nAFiV/BwwvLeI4Zfu3y43kblEWTszunsT6ACQlWR0JiQq
rMm5mjNWnWi/QiDwZJhzZNnqHeIOHoQCuPiXegaj2Z9ZFbpRtlo=
=NpWk
-----END PGP SIGNATURE-----

--gt5czcylmc7sk4zv--


--===============6266063231941738675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6266063231941738675==--
