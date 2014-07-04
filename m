From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] regulator: arizona-ldo1: remove bypass functionality
Date: Fri, 4 Jul 2014 18:52:17 +0100
Message-ID: <20140704175217.GF19453@sirena.org.uk>
References: <1404464116-21038-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ULyIDA2m8JTe+TiX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404464116-21038-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 04, 2014 at 09:55:16AM +0100, Nikesh Oswal wrote:
> WM5110/8280 devices do not support bypass mode for LDO1 so remove
> the bypass callbacks registered with regulator core.

Applied, thanks.

--ULyIDA2m8JTe+TiX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtunOAAoJELSic+t+oim9LGIP/1/MR7dvAuHTac6R4WE6hwTA
6odbGgCgcUdyFPiI+4bveW8/O5pLQjEEnwx1dc+6hGwpuxSPgRFoO+yGbdWpYUUp
O9eLftxAHg8rDTRSBEg/IvlGVS2i9Ftl6X9q8P0wWQMxX1jrQpwJ2IC1D3XgdlWc
lRpDQp2EHVrAZ/ynWiNLsTRg/mjKMXbzmNsZBy5C3t4+usb/MVo/0HW9qPMpC8Ox
BbpjKjgCP+rQiLQtQMLiU2Z5iDE3EcTnl4mlbwLg5w5DTanFrZIYdhes0wfgSn4a
kd3IcB924QZ85Nd0LXDArGovvtKOCY+jLqRwH0Ms23MWVQM4WzdWvSeyaEmpYsSZ
lvttTFBGJTB8532seRY5GhdtQhclY+RLLCyWsknMDEOW7ZQIQrYnhJVY8SLb7I5v
mYTjeKfLWdxsInAU2iVFXZm9VSjL1vVPb61Oy9QEvIytwGlKa+B/x6/HYo/HZqio
9mdCG96GKXAzj2+e2tO9n5EAFn/y19F0wFjrVQWXZIxXYKr65ydSsxOYWw8f8Lh+
ai6pSuh+gVu7kPEHeQylIdLc3ttLeTPhnYFcPMw5/fGil0SYMJrNMvj9Yaz7hKGn
Dck2WZEh5nZ9MHSE+WwUPZX6L8s7zRX/f7kG7/LjW1crtaffCsiLh+NKyhXftnVL
JmFjqb2lB+NnDKqjo32k
=v0yH
-----END PGP SIGNATURE-----

--ULyIDA2m8JTe+TiX--
