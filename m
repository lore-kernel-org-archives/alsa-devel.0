From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 2/4] ASoC: simple-card: Remove useless function
 argument
Date: Tue, 25 Nov 2014 13:49:45 +0000
Message-ID: <20141125134945.GG7712@sirena.org.uk>
References: <cover.1416918909.git.moinejf@free.fr>
 <2ade2a90025d3dd4fe8872d36956ac08f0a81103.1416918909.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U2airnvjqUwLRQVR"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2ade2a90025d3dd4fe8872d36956ac08f0a81103.1416918909.git.moinejf-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--U2airnvjqUwLRQVR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2014 at 01:22:45PM +0100, Jean-Francois Moine wrote:
> The device node pointer 'cpu' is not used in the function
> asoc_simple_card_parse_daifmt().

Applied, thanks.

--U2airnvjqUwLRQVR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdIj4AAoJECTWi3JdVIfQtc4H/3HtqS65ZenOxdk3xQ9vT8ia
Y4hcLU1qZ4j6PDZ81l3YxZh8++HHJY0BmrZf3Tcl9AEx/guXfgwpPjY67GT9E/kM
gP+Ry6id2pjcYPVOw0K4wp2a9Q5hiGj7jgy4lL17fjpaI2k2T3NYyiVXtUZ/s1na
VUqBQr48Vjb0QakRFkQrExDBqqaE1BlQcp59+acAVj9tPo5toMbf1ITNzGy1KxzT
J1wSbmAVwPDxuSAC2G+14AqsRrLuyOR9y+Wy+Xw+e6U6KB6KQJZ7vV99MbAYG2E5
6Wc2/YDElVLq1+3xeI7i8mZlakcBqsxqMC5BPBqNUNrjROM8s645EEyf+yLTaaI=
=fEv5
-----END PGP SIGNATURE-----

--U2airnvjqUwLRQVR--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
