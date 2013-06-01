From: Mark Brown <broonie@kernel.org>
Subject: Re: aplay lists both Playback and Capture devices
Date: Sat, 1 Jun 2013 22:05:34 +0100
Message-ID: <20130601210534.GU16790@sirena.org.uk>
References: <CAOMZO5Cq8xSj3fGoZEO+K5xxJNfHotC2PiuX62q+p+yw1-i9Ng@mail.gmail.com>
 <51A736C6.2060500@ladisch.de>
 <CAOMZO5C3eDi_wicdJLab5Dg1yqexkJ6Ffhwwft_2XnO5KHPD+Q@mail.gmail.com>
 <CAOMZO5CfQUnRN8h5gSFV8qAu2YYw4B3hZRBfgkW5DzEmAb3-2A@mail.gmail.com>
 <20130601190622.GM16790@sirena.org.uk>
 <CAOMZO5BTv2oqZzwXcWs=K8r+tdzCR8MA+DuopYaBnH+fw5Hsug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3450878601558718124=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 66ACD261ADE
 for <alsa-devel@alsa-project.org>; Sat,  1 Jun 2013 23:05:42 +0200 (CEST)
In-Reply-To: <CAOMZO5BTv2oqZzwXcWs=K8r+tdzCR8MA+DuopYaBnH+fw5Hsug@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Marek =?utf-8?B?VmHFoXV0?= <marex@denx.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org


--===============3450878601558718124==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LtN0I0gXzHUftVCi"
Content-Disposition: inline


--LtN0I0gXzHUftVCi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 01, 2013 at 04:20:50PM -0300, Fabio Estevam wrote:

> What is the proper way to know this information?

> Or how do I tell that each DAI is unidirectional?

If it's not got any playback or capture capabilities.

--LtN0I0gXzHUftVCi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRqmIbAAoJELSic+t+oim99RMP/2wOY42aF9/BYV8iP2WCTopY
EgIotMmrew3KGoKWmZRNFJIyXSuTDmxeepaHRbdBN7y4z5tNtKAxSUhzFGPM1Zhf
ZPVEF5/wP/vmMnLVJ5+sBbJWDQ9azf9IGZrxUwmq98Q+1rTspnYD3VJOdWMMUwQD
CoDlA0CpdBLyIHkWG9Eut5zKzrucs2L4wHi44a3tI4yVt2YyruFErafcwtd4H/hf
fgA9lcNdD9u9Ow3SzkfiqijW8EWEVhl1Yp94dCdm4VooJjQMspzdUIHzCENhx+W6
7IlfSB1+Rbw96/Ak/Asri/jVXQMCTIyF9j4BiSZJYPAcZjvIObRP14A8sWbzSVGM
f0dHEEcFIfN4dYembUugFYTUQ8QKc4nWHrLJa2NU2hJyBjnIq9B/IG+KagNr8Kmw
4gE90XhivGu+dj/RLHQpS+q1QuNjO/pdszNgyEj3y8QSvHlTjcpXvoxzN9N++fGf
0S4ZWXw9mRMisYNqDA3S5OhqMyhPtVoBefU5niRsCw63a0EsrZpjbV0S9p/xMSeY
lSvUYjC2uzyFT/KImKShoz4Pd5S1KIOYfHISJpsWebO+xxDRoViFsvPmRyO07NL2
QlXUyvke9FKUsmjlgAvouSKbyOMLYAoCebz/kdqAv6TsS93BL8bMO4vfOX+kD2ab
W2TtZ1OynjWaaBSxyaEF
=9bjW
-----END PGP SIGNATURE-----

--LtN0I0gXzHUftVCi--

--===============3450878601558718124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3450878601558718124==--
