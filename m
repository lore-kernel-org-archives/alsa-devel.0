From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_sai: fix the endianess for SAI fifo data.
Date: Tue, 31 Dec 2013 12:24:01 +0000
Message-ID: <20131231122401.GO31886@sirena.org.uk>
References: <1388475202-24946-1-git-send-email-Li.Xiubo@freescale.com>
 <1388475202-24946-2-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MCBkylF/aX/f/TlX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1388475202-24946-2-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--MCBkylF/aX/f/TlX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 31, 2013 at 03:33:22PM +0800, Xiubo Li wrote:
> Revert the SAI's endianess for fifo data to/from DMA engine.

Applied, thanks.

--MCBkylF/aX/f/TlX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwrddAAoJELSic+t+oim9yl4P/0JrSx4Ym9KA4Ke2Q0YiLuiu
XMr+l2DgTRdMWa6cJpqD2rAM9S9mre7UzRCUKKCbYb/DUZawwZSr/im6+K5xa3J1
gLnOdPvOH1dWWzL57mOGE1TUw+You5sKi0olk+Cg1t2u/qfr20ImAHFzNxiSVIs2
pvr5XviFTRmnRH6nk7OUGWg83lHExPrcGvE27PhBY6GJ/75MxgCrJVhEjNt7xjfM
o7e+ZOK31C12uT+bMfgj3jtxolVF8C45wkMH9NEWATaCD1v2POyQijkURrPtwOVu
/zfXkYX+1ByQTzxZo2KZdiwKakqfQOEGDGVYPlz96uDIe2uwj7DMgfBM6uEPphSX
oxK0CI0rFtcpX7m9E2d2i38vf/BDI8k3ZYJj7zZV8Jfy/nNQKqR2/5i+kY0YdsA/
40gfh2TBZwiOHutoc30Zb5+ss8bTkGQYEeCgw9U+b1DrY03esoaWPPFM/ztyTp62
PWoG3e/GLFYhzBPhOkwuab7nOdn4h4A95AsFCzGNisy9Mnho0MK3ALhn13Gqixxu
KWyVs74tFozIlYFzjp/kOJ5g6VKXIEJwldCt9X5UkAegeg6Jps5peMoHyYnFURP7
dvLmUltFp2GSTVxVyewrVwBbRtPybfIMMKgLMxyVXeXvXmh87msH/6gV7b3lwEgN
dvf6h/nYDAtQNiAeE65J
=iJK2
-----END PGP SIGNATURE-----

--MCBkylF/aX/f/TlX--
