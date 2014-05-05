From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/8] ASoC: Intel: rework the mfld
	platform driver
Date: Mon, 5 May 2014 12:47:54 -0700
Message-ID: <20140505194754.GW22111@sirena.org.uk>
References: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2940087562373892220=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D50E265044
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 02:59:01 +0200 (CEST)
In-Reply-To: <1399308565-14620-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: jeeja.kp@intel.com, alsa-devel@alsa-project.org, subhransu.s.prusty@intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============2940087562373892220==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2NVUe83uzBILE3UT"
Content-Disposition: inline


--2NVUe83uzBILE3UT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 05, 2014 at 10:19:17PM +0530, Vinod Koul wrote:
> This patch series reworks and reformats the existing platform driver we use.
> This is stepping support for seconds series of patches which will support
> Merrifield platform with DPCM based implementation

Applied all, thanks.  Please make the body of your commit message
standalone, don't continue a sentance from the subject line - it makes
it look like something got corrupted.

--2NVUe83uzBILE3UT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZ+rnAAoJELSic+t+oim98SYQAJb5obPGv6fFyMoKpUsAPtma
rjinuxbHzpuiqpygr9sakEmLqISFo0gs3yUluYFq+64n5oSn2ecGO/a5Rn+REONG
FIonZ/BmAsTfaVJSaV8PRcvzirWqora1++IplEUpRR/J/dEWzY4FqInVKoBNn8Uq
nqyTgHAHkRA+kndLcaGR0XT1ebuYtmkHOFNLELtmgGYRYFrM+5t1wnRHZYj8lrCv
I5SDyUegWNpjLqnK3e/BpEDZq6ku7FInP7KekV05vTfSfRNodqUzVnBW/mbvId/M
OpIdwBVo9bx+sSjQOp9CsRTyGpBEHJ5O3D4DvODirOrlF3QZEFAsDnWme1/Ijyw8
z/rdJHYF9fvod0YpdTaIx9lGFGyluO8iMkweHxabtVYg8USeVmV7NO2rK9ljhOcQ
PWEUWkBIpWA6gHFU2DDqT6X5570KH2v+ENd75FFXObXYQE++oD6IiMW+o7vYPc6p
WHXm6+tvEMMl+6baniwXMIccrwvVsE/qe5z8tfAozIsjA0/k2ljoa0rsG8H6zNCE
0OKyRLGQsMa/JyXMTfUfN2LVtPWO7ROza+ESSpCqhze0+mEZNm5S4krXGwdbfIri
0IzEYreIUYhJQNMF3mEkqvltmJOvmfx4AO8KG0MEfJ1Y6yAVHod/2rzkx91Sz9mV
14BJA+evhd3b1PTsO/l/
=PhcN
-----END PGP SIGNATURE-----

--2NVUe83uzBILE3UT--

--===============2940087562373892220==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2940087562373892220==--
