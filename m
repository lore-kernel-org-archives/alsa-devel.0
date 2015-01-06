From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel][PATCH 4/4] ASoC: wm8960: Fix capture sample rate
 from 11250 to 11025
Date: Tue, 6 Jan 2015 17:38:38 +0000
Message-ID: <20150106173838.GI2634@sirena.org.uk>
References: <1419997154-860-1-git-send-email-b50113@freescale.com>
 <1419997154-860-4-git-send-email-b50113@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ca5z/wkVxIQXz1GF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419997154-860-4-git-send-email-b50113@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <b50113@freescale.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, lars@metafoo.de, ckeepax@opensource.wolfsonmicro.com, Li.Xiubo@freescale.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--Ca5z/wkVxIQXz1GF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 31, 2014 at 11:39:14AM +0800, Zidan Wang wrote:
> wm8960 codec can't support sample rate 11250, it must be 11025.

Applied, thanks.

--Ca5z/wkVxIQXz1GF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrB2dAAoJECTWi3JdVIfQelEH/jL3UfPiaRzgn07S0BCZi4dj
MN9Eyrgraz7g2bmIsii6ghhzARo7HIrjzzGYZKP5Adwf7cwOa8km47jliNUs+3/w
TBKIKFEa8Qo1y9e8d0ba3FrXnVZ5/5PqBHAihzj9Wbq/ddUvUCDW+MaNZGVMPWhd
g4ekY4plljK8G+J04efQMUdPNZ227z9B3CQprTfsfM4yXLcJbSKzV49BQ3N1S2/P
k6E9SCNRX9djUc1ktn5Px87Y/ABZyIH96Im7B+hJSoTEGCh5/EH3MpPBvNwnCdeY
Zv8pcb/8eltBe7JGyPGHPLttUI0l4bI2p6XNvJZFJt/IppGmUuN5aB62FUXrDgA=
=zWwH
-----END PGP SIGNATURE-----

--Ca5z/wkVxIQXz1GF--
