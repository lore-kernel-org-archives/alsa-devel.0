From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/4] ASoC: tlv320aic32x4: Support for master clock
Date: Sun, 23 Feb 2014 12:59:47 +0900
Message-ID: <20140223035947.GD25940@sirena.org.uk>
References: <1392916981-9333-1-git-send-email-mpa@pengutronix.de>
 <1392916981-9333-2-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rvJlijl7rx+y0eL3"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392916981-9333-2-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--rvJlijl7rx+y0eL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2014 at 06:22:58PM +0100, Markus Pargmann wrote:
> Add support for a master clock passed through DT. The master clock of
> the codec is only active when the codec is in use.

Applied, thanks.

--rvJlijl7rx+y0eL3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCXIwAAoJELSic+t+oim92lAP/29YjhrfzHV1SSX3SS0SFcYX
zz8X+ZxyB9iTVYbcVshVnscDbML0trnxWQI9UbZyuOTYXwaADZZBlW/AOkwyl5xv
sATTmLIfobuUhssI5GRDvi/VCeZYMCh9SrNek+XNq62H7W6KTCSr9zuo+vssk2Tg
Muza65DgrqtyPkxJ7Tl6tE5LMUHc1i4KecS64dlBzN3PVp43dQhiyMoJ8BJy+cPI
1IGfB0PBswCE5pZa8t5qC6bjhraEkpxHjKlyKvUAev++JeWxwNFDExw8x/2kW8NU
Di0OXin30aOT+fhmbE5VUz16Za/nfs/voZq1BklS59AoixTXstg3FyqnXSBY+C8t
AKvI+8i4FZUj8sMtDIF3WZ4/Qn22ZLzdQT2E5zYNbW5P+3VMWGXqSYXdGvOByWeL
BFwfO59LXHHtaTGjdUCfnqpy/bnRqgmB102P2z1Pb7QPK8wbLaSX1jPX6Uq2sZox
v+Ruogho8b7pQZyL/J1rWM8vfU+uNf2tUqTYbSyj63Wjb5GiHQ5JhnlIaffCAhLi
a2Rr+gfLUdBS5RKfHejs/aAoNSBolAbrk2PUkIz3lWkjfm58GDWbYrFlT8KZe0n6
xdTs+V9enlxSogQasPo31xrO/BCMBKa0kCXoOZ4Hm1SduguPL6aK6kUZ5psvG5/m
f8RH9G44WDAEiFZ7HtyL
=KIaB
-----END PGP SIGNATURE-----

--rvJlijl7rx+y0eL3--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
