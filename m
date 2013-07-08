From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 3/5] ARM: AT91: DTS: sam9x5ek: add WM8731
 codec
Date: Mon, 8 Jul 2013 15:36:20 +0100
Message-ID: <20130708143620.GF27646@sirena.org.uk>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
 <1373290193-25300-4-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8098502373260590807=="
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1373290193-25300-4-git-send-email-richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--===============8098502373260590807==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vmAJtI3ncFun9MAx"
Content-Disposition: inline


--vmAJtI3ncFun9MAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2013 at 03:29:51PM +0200, Richard Genoud wrote:
> The WM8731 codec on sam9x5ek board is on i2c, address 1A
>=20
> Signed-off-by: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This should go via arm-soc.

--vmAJtI3ncFun9MAx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR2s5aAAoJELSic+t+oim9WOMP/2cxxwVEWX3VmRHWRCQooQth
wGxyk7WVqb4JUschwhgTjxcNexDeg3A6L0GhgKNOyqbFLux9EChTqyp7TMsfgPvQ
Sf+ZFA1nDMHCjgU/iGHzVd7NZVuXWf9LRwji+IT4anZMPWBO71Xv7XdDTXvGSvbb
bX3UsqKgiU0p/QUTKCtWgaXUPNmdtpUw8NTGWkBSB97EgU12JtvKUZKi6gOl5ZrC
kGcrWcgPbcrEqPsHuQZZQB3PChl9LV/xPU76PH2yDGMLb/590/zuVSEqyad/3jC6
nxs6Ti32EMm+XbWben+MRBLKIZJzM+Uzw6RWOQKXUK8lObPZ+ZyfRY5KG6JpZY6v
jPAR5R1ScKadF+J7hjIxjpGIqKiOYmH5Ckr3WonXQXlT9ygd5Ji6tzxJIs9f6NYY
mHFpGjbd/6SzHiXUx244G8bI2oEQuBWfhJag9pltUF6oMZUxGMEwWOd32sBUba59
4cQvR4Q2lFsXy0kiKtqatxCrrYVspFf4fPrbfJYkxjicZ2cqUXmrXuzYJ3OMmXKM
2h2lsN3Ao3rBqbzfkSvv6FxQcKXQWIrNFLy2GDsig6qzvcsMINmkbxWL/Ohp7FM2
HMpMbWVPhJF/8dtK63PMcE5PwXVRpZxqSmXB8Wt5MphXfMEwtEod2ZNWf/iAaPs5
2IC4nKzY/w/q1Ijnd1Ik
=yrBV
-----END PGP SIGNATURE-----

--vmAJtI3ncFun9MAx--

--===============8098502373260590807==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============8098502373260590807==--
