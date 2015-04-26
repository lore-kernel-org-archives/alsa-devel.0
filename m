From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [RFC 8/9] ASoC: hda: Add for CL DMA interrupt
	handling
Date: Sun, 26 Apr 2015 19:58:40 +0530
Message-ID: <20150426142840.GV2738@intel.com>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <1429276567-29007-9-git-send-email-vinod.koul@intel.com>
 <20150424173011.GW22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3029879998120752974=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E64DF26129A
 for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2015 16:31:33 +0200 (CEST)
In-Reply-To: <20150424173011.GW22845@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3029879998120752974==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nj4mAaUCx+wbOcQD"
Content-Disposition: inline


--Nj4mAaUCx+wbOcQD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2015 at 06:30:11PM +0100, Mark Brown wrote:
> On Fri, Apr 17, 2015 at 06:46:06PM +0530, Vinod Koul wrote:
> > From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
> >=20
> > DSP handles the Code Loader DMA interrupt.
>=20
> Could this be squashed in with the thing that adds the work so we see
> the whole picture at once please?
Sure...

Thanks
--=20
~Vinod

--Nj4mAaUCx+wbOcQD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJVPPYYAAoJEHwUBw8lI4NHHA4QAMnI8V3q1sni263GIDU9+8VC
L5plTkbt05oKbxfWZ86847QMwjpodrozdZsu30jqg+ak12ABVlS1rx2zJ8Q6eMOp
8lXqIcx9Cb9MHt14aUax6TjAQIx+PH44IJE2b4HRNv3G+5sgQPEzBsD9vWT6K3cx
0MUWFMCzlZPCQoFSH9PwUO2W06qubnFhEDQmYz947EjKasBUXRIJ0vBYivr4ZmJ7
8r/xn6EO7lyPaFfYcYlQZqyQXGRxBk681W44Pzp5YPGK59t4zjxLAGGqbB5mOy1L
xpWvm7UE1wwQnBR1dLfV6BKqarC/B75yG4mHyG/YoLtly0mKVVPiKef38Cyu/kOA
fD5ZGs7ZXC4MmXVVRDPMkdjb9SYP5RCrpNvC+t786jUGpSbU57GshP5Z/HFOMctC
aDiszWbS3PdnHo25cVsC1HKRDtRRztEv3lPgV0WNT+behm6VQrYiYE9ucFFtIlGl
2yJofSPZszFwR2cxh2JQJuSfgpgUex8u778gZ06YsxuqmZSogkvnqe3Er0oH0ypI
X1DYFNjOalTqoTgnPZDXHq6U5XbLN5iXxtWFUeCEifiLPC0QAE5DKz73U7fLHV8e
h0/5SYuf6ND4nKBK0cdZILsjJ689xrKtgpuNxqfSdkWtGSvRUjbtZFa/jkUzd4Wj
8cHiYvsk04t8mQOw6apx
=JayY
-----END PGP SIGNATURE-----

--Nj4mAaUCx+wbOcQD--

--===============3029879998120752974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3029879998120752974==--
