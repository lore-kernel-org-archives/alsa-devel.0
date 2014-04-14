From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ARM: dts: Append clock bindings for sai2 on VF610
 platform
Date: Mon, 14 Apr 2014 21:38:51 +0100
Message-ID: <20140414203851.GD25182@sirena.org.uk>
References: <cover.1396432924.git.Guangyu.Chen@freescale.com>
 <d09da3eb629143abd3f61ae037af4ddaf7286a83.1396432924.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0318140547564076325=="
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <d09da3eb629143abd3f61ae037af4ddaf7286a83.1396432924.git.Guangyu.Chen@freescale.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, pawel.moll@arm.com, linux-doc@vger.kernel.org, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, timur@tabi.org, Li.Xiubo@freescale.com, rob@landley.net, galak@codeaurora.org, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--===============0318140547564076325==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bwMunqOr7B7rzQrh"
Content-Disposition: inline


--bwMunqOr7B7rzQrh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 02, 2014 at 06:10:20PM +0800, Nicolin Chen wrote:
> Since we added fours clock to the DT binding, we should update the current
> SAI dts/dtsi so as not to break their functions.

This doesn't apply against v3.15-rc1, can you please check and resend?

--bwMunqOr7B7rzQrh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTTEdYAAoJELSic+t+oim909YP/1fePSP/VU6q5ZG2V6LA+Ien
nDePfbzPoLOsJA05Wg8OFj1xKg5TLpnk7ZAqRr/kg4dLxp8QdEO1LlpR9f/YNBdw
5NKYyQDCGNf6x0Qglbr8v2vrXlrV7CeWIeZ2PLE3S2O/0YZUXWGw7vy6mz/aNjFL
DqyNM/MQft/FNHN+A4odSGRT+zQkDM6chtAqCQa7/Xw0y4F9OsbWQCRXb4Q+KxL1
bYwoc2xHonhUgZD01M0k80SXGcXfiAYDfx5a5l5u7+K3hz0HVGudsHclaSI/cy4T
PUGi3sZ9i+oLwdmrYtNPAmmllcY60+VTbdWdK2EJrE9MUpaCUOhtvoqqcQ1WD7iC
iWaDJ8CCer4rHo090cPQwejlnb62VVeLsZrjKyZXMT/XupxnJQo7Nbhs7gSbUwWb
mi6q+A/+DvyaMhZMbKRdjQhoED6xoQjArirWLmKiNPH95FPKDAwMo+AyqYvPGJWy
5KAoMjDIaV7zrTlZSRGefgpBhKzCGQBxg+P2NSmantEX94rKW43kwQng5OlMRhV2
nSQ/x3Wj0xPZwxhfQS/KDaGpS32KSnj1lFCbwLRFuNciphzmXRHI2/4IeVoQzvvZ
yi+sATUjrrcshPU4qLdsp8h2GRiC6Uz06+hmCPElI2Bvby3xt5E4k2zv49KzlsqB
LMedOA0Rd2Lg6ygCIfYE
=3HvM
-----END PGP SIGNATURE-----

--bwMunqOr7B7rzQrh--

--===============0318140547564076325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXhwcGMt
ZGV2IG1haWxpbmcgbGlzdApMaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZwpodHRwczovL2xp
c3RzLm96bGFicy5vcmcvbGlzdGluZm8vbGludXhwcGMtZGV2

--===============0318140547564076325==--
