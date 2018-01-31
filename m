From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ASoC: codecs: Add support for AK5558 ADC driver
Date: Wed, 31 Jan 2018 17:08:59 +0000
Message-ID: <20180131170859.GC7763@sirena.org.uk>
References: <1517403459-6668-1-git-send-email-daniel.baluta@nxp.com>
 <CAOMZO5BToV0OKEc_f8M1=zSL-X=qSXnokFyEfEEX2tGTUO=a-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oJ71EGRlYNjSvfq7"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5BToV0OKEc_f8M1=zSL-X=qSXnokFyEfEEX2tGTUO=a-A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, wakasugi.jb-r6lgfPJHJciWyREYz5tgSuqrae++aQT8@public.gmane.org, shengjiu.wang-3arQi8VN3Tc@public.gmane.org, mihai.serban-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cosmin.samoila-3arQi8VN3Tc@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, Mihai Serban <mihai.serban-3arQi8VN3Tc@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--oJ71EGRlYNjSvfq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 31, 2018 at 02:20:31PM -0200, Fabio Estevam wrote:
> On Wed, Jan 31, 2018 at 10:57 AM, Daniel Baluta <daniel.baluta-3arQi8VN3Tc@public.gmane.org> wrote:

> > +       dev_err(&i2c->dev, "%s(%d)\n", __func__, __LINE__);

> You certainly do not want an error message on every probe :-)

Sometimes you've just got to be honest with people about their hardware
choices! :)

--oJ71EGRlYNjSvfq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpx+CsACgkQJNaLcl1U
h9B2iwf+JFWIP6EjUfINlZZ7JvpAr96cX3SyKanWXBU4N+9peL1zDbwXYNT8+KVw
Mp03a2fClB7NgTqLR5xKF0vPecfKbKMzk0RUKaTBu/rsHTguEsen/EegKcn3s4Ix
vBIWXhoGry3m/XMlL/EgaDqAHRMRnFVlCJkzcYhXbdnjmnH3jxj9N6CMAyz1tMXa
KMzzMs7Y4PJOzG0eub5GzcxNmW9UKqUIkO0Hwheaxlzet41KB5Z0zCsbxOOM/y06
wcml2/tT80ekc/5v8Ldo9sl9pZRRDiWdv8TNIzfLf4XaeGPeY5LyQkd2SIM0kY7g
W2I6OBZ/gRuk80aTwXlohFxJL3iv2w==
=Jhgu
-----END PGP SIGNATURE-----

--oJ71EGRlYNjSvfq7--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
