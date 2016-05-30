From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 0/1] sti: add audio interface to the hdmi driver
Date: Mon, 30 May 2016 16:07:19 +0100
Message-ID: <20160530150719.GM29837@sirena.org.uk>
References: <1464615097-29446-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0324218110=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1464615097-29446-1-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, kernel@stlinux.com, Liam Girdwood <lgirdwood@gmail.com>, dri-devel@lists.freedesktop.org, Jyri Sarha <jsarha@ti.com>, Daniel Vetter <daniel.vetter@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============0324218110==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/t6ASE28jIy1gGy9"
Content-Disposition: inline


--/t6ASE28jIy1gGy9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 30, 2016 at 03:31:36PM +0200, Arnaud Pouliquen wrote:
> This patchset implements audio interface in HDMI drm driver. Implementati=
on is based on=20
> ASoC generic hdmi codec driver( https://patchwork.kernel.org/patch/871314=
1/).=20

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--/t6ASE28jIy1gGy9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTFcmAAoJECTWi3JdVIfQWCcH/1A9YlVP8uaYaagmnY5QNoLu
y1vbOb6AZej64/Qbyo15unKJ8BUDbquij5mbyxZEOWncIzk274yQhGncmGuO/KBd
K/YP4o1CTKQ7oJaSmWePsLOz0T0B4UA5Em/xeGwsAvR9T/xjnexDPjdj6FnA0k6I
YKOmJ9T1xeIYDBbBv4dDGhz7nKeaFpLBPdBFCBdrz+ftxVmHUsqgmYqbad5DczC9
uA4UO1Se+zuAaFfsXUub88tUr5/AHK/UWrX51gGO/O7W3RhUVgAoreChZ3mZBQ0i
OAeZQDRcEQmjaAsz7oBm423dezjey5DMhbzhpQ+PseIH/vU989ihvKR59K1vZy8=
=ltJW
-----END PGP SIGNATURE-----

--/t6ASE28jIy1gGy9--

--===============0324218110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0324218110==--
