From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 02/12] ASoC: rockchip: pdm: using left justified store
 mode
Date: Thu, 4 Apr 2019 14:51:17 +0700
Message-ID: <20190404075117.GP5748@sirena.org.uk>
References: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
 <1554298856-59028-3-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2967820125999140210=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1554298856-59028-3-git-send-email-sugar.zhang@rock-chips.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2967820125999140210==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2uzDqHpccQJpqF2n"
Content-Disposition: inline


--2uzDqHpccQJpqF2n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2019 at 09:40:46PM +0800, Sugar Zhang wrote:
> This patch set left justified store mode default.

The changelog should really explain why you're doing this.

--2uzDqHpccQJpqF2n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlylt3QACgkQJNaLcl1U
h9BM/wf/RDkvVsQZ3WG2fWsFHy3bW6rpEvIQA/G/4sQqjHPgLKxzvxkLkblE7uo7
s/3H5SR3CiWNPaOkpli7sFpirI+PxwlgtrnlJQrf2/ayJybXYA0xtFirscA5tR9a
Samz9fs5UWF00szRHtw6TXsBAGIB2OiQi1Y6CqaB+LbzuXvkeLdPEAk2atJUmA5Z
W3lbpUcJ6b54lhLsPdr+gUOOL9GTYSYbyY7fFM8DZ3KGvTszZm10qX3RVkuOwbYi
DddxyWQI83tfR1cKIX+eQ3IeEPwfOv73tnvKYSL66ls0ge5UTkf1tzPjAgwDoiHf
ZMa97NGXs1Qm2KFWnnwCTmiW77qV/w==
=369W
-----END PGP SIGNATURE-----

--2uzDqHpccQJpqF2n--


--===============2967820125999140210==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2967820125999140210==--
