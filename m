From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2] ASoC: fsl-sai: using 'lsb-first' property instead of
 'big-endian-data'.
Date: Mon, 1 Sep 2014 16:37:01 +0100
Message-ID: <20140901153701.GE29327@sirena.org.uk>
References: <1409296332-39318-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hjFmXiTvfEJBEd4m"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409296332-39318-1-git-send-email-Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--hjFmXiTvfEJBEd4m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 29, 2014 at 03:12:12PM +0800, Xiubo Li wrote:
> The 'big-endian-data' property is originally used to indicate whether the
> LSB firstly or MSB firstly will be transmitted to the CODEC or received
> from the CODEC, and there has nothing relation to the memory data.

Applied, thanks.

--hjFmXiTvfEJBEd4m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUBJKaAAoJELSic+t+oim9ezQP/iq+xwP3e+Cl1cHOnMtPK3cQ
BU6mMZLExN7KyMuAdFFO6O8z45HRcDZNQljday2KbFUnFLWHsENuHoI+cvVg3zJl
bpQSA064rEeCy0NE5jE/9p9EkRdEfALg1l/ixXDgzvJhb2rZ+DHF+UlKxQ9FmkoE
2IeWmMSTCqBJixmA6e2umQIEGfIQlrGZe/EbKYFrYBXEVhJwMSrj/uuzD4Qy1vu5
xL5GpZM4k+8KsBtfcnDgZKJop9ptGejs5yhmq+eHYBKx8LlL2OEmg4//jYcbPWVR
bJXsSM9urj1dY42eaSr1iRfekPFMz3X8mKlnE6O0FS5fTMVAzUssUHIErqy0oQwa
1DL26aKtz8f6iTsvs3GAgcjEgMCi47kpQ/Ch9ltcmBPaurFpW5jnODKMNZHfnpnt
bZmBp3jbU6RaXeA86wmhQqQtpHsliI7GSlSiqrnshTcTXgOPTOoLsGLEzevNToB2
8OXiXHNUV92T/QRv8guwFUHGf6gnvv14jC1C985iHqfRigRx0M6mt05EZ9ytCSGb
9P+gEeRdNrqu+ps51dfDYc/FFfVnNPSkm79XKaFY+J9KI/xCyq8uELAPJquGyVrk
iUmV2p54l19K26JqhAKa9Nexk+9a4olQ9EBDRgKZvXiIuaVMQ2f+eNVas4n7jqSo
n3245u7juufEH2Kqpmnv
=1HP2
-----END PGP SIGNATURE-----

--hjFmXiTvfEJBEd4m--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
