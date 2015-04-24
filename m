From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 8/9] ASoC: hda: Add for CL DMA interrupt
	handling
Date: Fri, 24 Apr 2015 18:30:11 +0100
Message-ID: <20150424173011.GW22845@sirena.org.uk>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-9-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3366295371476769194=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A5812605FA
 for <alsa-devel@alsa-project.org>; Fri, 24 Apr 2015 19:30:18 +0200 (CEST)
In-Reply-To: <1429276567-29007-9-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3366295371476769194==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ygWf4kcx/ipMngqR"
Content-Disposition: inline


--ygWf4kcx/ipMngqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2015 at 06:46:06PM +0530, Vinod Koul wrote:
> From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
>=20
> DSP handles the Code Loader DMA interrupt.

Could this be squashed in with the thing that adds the work so we see
the whole picture at once please?

--ygWf4kcx/ipMngqR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOn2iAAoJECTWi3JdVIfQ3FIIAIbDoryd12n2u7UKz0ztDkbC
5A3aXz7150azBwTDwVo6bwb6rKliRdD/hmnVfL6kvNBP55XYIPOykJ/i3XIAsBAP
kqBSj7BkKtZpdaRR5N5VNF/6fKue0AXtUjcWggyReyuP/hz3JSkPzDxj5f6dmPwy
OOaTT5R+HYGA8oMikpj/APJNu/2H28OxFf9glNB6DJL9XQot/vql9dRJHLP0+XMe
vQRYbTK1QQXAJgeMl4tBZj2/Y603Zwv7/xPhGtQrZBAtfN0JfzxcXU+dRr5Rmw/H
SzBviLMzfMzxlJOepOkrgPgIqMgwll7ec1Ww9+IdWKQ9F18r71EU+SG1nnzGig8=
=zxf9
-----END PGP SIGNATURE-----

--ygWf4kcx/ipMngqR--

--===============3366295371476769194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3366295371476769194==--
