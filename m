From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: amd: Report accurate hw_ptr during dma
Date: Wed, 8 Nov 2017 16:05:54 +0000
Message-ID: <20171108160554.qgx2rkewmbpfcdf6@sirena.co.uk>
References: <1509741345-1589-1-git-send-email-alexander.deucher@amd.com>
 <1509741345-1589-2-git-send-email-alexander.deucher@amd.com>
 <20171106154800.sotryjiadmobitac@sirena.co.uk>
 <e1db3baf-44f4-c35b-680b-822962823180@amd.com>
 <20171107113714.bohg3f7ys3wygifn@sirena.org.uk>
 <b7394063-321f-581f-2ba2-d87e277574b6@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0723287992=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <b7394063-321f-581f-2ba2-d87e277574b6@amd.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, "Mukunda, Vijendar" <vijendar.mukunda@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============0723287992==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ol7vjagx4luicymf"
Content-Disposition: inline


--ol7vjagx4luicymf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 07, 2017 at 09:34:35PM +0530, Agrawal, Akshu wrote:
> On 11/7/2017 5:07 PM, Mark Brown wrote:

> > > > These two URLs are different, what was being reviewed here?  What is
> > > > Commit-Ready supposed to mean?

> Same patch is reviewed, once on 4.4 kernel (659699) and then on 4.12 kernel
> (672267).
> Commit-ready is to get it merged on tree after receiving a +2.

OK, that's not unreasonable but probably best to mention if the review
was in the context of a very old kernel, sometimes upstream changes can
invalidate the review.

--ol7vjagx4luicymf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloDK2IACgkQJNaLcl1U
h9C4NAf+NqzMWvS0zbduNHhhSwXXgML2AuEr0LAkDam6jEHxaxIIejgAWqktnB4O
Q3RcD4zTuHSaH6pXSJ7eV46KvSwgvpEUItqIYmk9lePAMTXuCNqXAnOiFCYO93xq
BxXiiwioIPKuBSXV9/NimD9uO4ljW75ypm2T2xygWCmyaX49XAj0hsl1M5pXKg9l
J1FiqJWnRWtMZDnNXxw6xERpC6qP6xoJVGaCoOh762PgrOFnaY6zODrypmyLlPoQ
iriTwnCl4+6OlqrPuaNEsIcm3GUewULAt/78O4Ogync0UCeCA2Rn6MYEmsvQ0OqA
NtjHtpOqwzg5L70VV7A4NGVoGm0Xgw==
=CkR5
-----END PGP SIGNATURE-----

--ol7vjagx4luicymf--

--===============0723287992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==

--===============0723287992==--
