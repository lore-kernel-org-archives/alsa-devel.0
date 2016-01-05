From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 03/13] ALSA: hdac: Add support for hda
 DMA Resume capability
Date: Tue, 5 Jan 2016 15:51:08 +0000
Message-ID: <20160105155108.GE6588@sirena.org.uk>
References: <1450431729-27259-1-git-send-email-vinod.koul@intel.com>
 <1450431729-27259-4-git-send-email-vinod.koul@intel.com>
 <20160104055715.GD2940@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2396557292770980045=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CFC852612D0
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 16:51:15 +0100 (CET)
In-Reply-To: <20160104055715.GD2940@localhost>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============2396557292770980045==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bi5JUZtvcfApsciF"
Content-Disposition: inline


--bi5JUZtvcfApsciF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 04, 2016 at 11:27:15AM +0530, Vinod Koul wrote:
> On Fri, Dec 18, 2015 at 03:11:59PM +0530, Vinod Koul wrote:

> > Skylake sports new capability of DMA resume, DRSM where we can
> > resume the DMA. This capability is defined by presence of
> > AZX_DRSM_CAP_ID.

> Can you please ACK this and path 4, 5 and 6 of this series, as they are
> on sound/hda/. I think Mark is waiting on that..

Yes.

--bi5JUZtvcfApsciF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWi+ZrAAoJECTWi3JdVIfQyhAH/1HZ2sPdtARloqBf5ueM/u/b
OFMzPO9Ef+MCEEtXeBuywphwgLLN32umOXYhE/ImHJ5DgabTy6s9w1ikSTyZSamU
+xIE9cybH/yUGQhUbCNB6M528dZVFOBbTHnl4smiOaieOj9hweecSHGY1ORLCk4q
6i6dmit3SmLDmRWAGuq6sHQSV9VDQXDiDqoFCswjJttOvEtnoMitbxOErn2S92kM
bJG9T1+636xKvPRZfSjLQZfjMxEV+1Nj+pW/mR+32HmYg44VfklKLRyJoVh8jXjv
+MhPA0Om1QwOcpAYBXaz86LtxEObR+epb0gPoOi+uFTsO0th6OBFjxx7HGtoo3M=
=GiIj
-----END PGP SIGNATURE-----

--bi5JUZtvcfApsciF--

--===============2396557292770980045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2396557292770980045==--
