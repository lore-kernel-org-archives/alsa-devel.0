From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 0/9] Add SKL ipc handling code
Date: Wed, 22 Apr 2015 20:06:58 +0100
Message-ID: <20150422190658.GD22845@sirena.org.uk>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
 <20150420214441.GW14892@sirena.org.uk>
 <20150422040046.GF2738@intel.com> <1429701598.2695.14.camel@loki>
 <20150422155308.GJ2738@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3612839525897626657=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C044F2617C1
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2015 21:07:05 +0200 (CEST)
In-Reply-To: <20150422155308.GJ2738@intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, tiwai@suse.de, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3612839525897626657==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PLVMksexArUZ/iL3"
Content-Disposition: inline


--PLVMksexArUZ/iL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2015 at 09:23:08PM +0530, Vinod Koul wrote:
> On Wed, Apr 22, 2015 at 12:19:58PM +0100, Liam Girdwood wrote:

> > We also need to port the SKL IPC code to use the converged mailbox code
> > that's now used by BDW and BYT before upstreaming.

> Yes that wil be done for next patch series. If you guys could give comments
> on the other tow series, I will spin them and resubmit as well

I'm not entirely sure which serieses are what at the minute, we're
getting a lot of things posted from you guys many of which are just RFCs
in various versions and some of which are getting applied or didn't seem
relevant (like the HDA ones).

--PLVMksexArUZ/iL3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN/FSAAoJECTWi3JdVIfQ1moH/2KhFFDaMhyfrshxwjCJ+ZfD
VYPn2U94qHJ1zH3Glw1y7d4UbQzrPUJptDXXqskJwKDrEVoYTdRiw8xZMS6rEXq1
x4o/dioBw2O0eo6LyvFDOoP1/9M7bqQCMJHMQTQ4o1R2c0YgR85+UQrRWAsnSzDK
ZqJs/V8PKjaMRC4k1NBtlUzNMRVg8N3sttpgn3QiTWAh8qA3kA3bKFCaeUlpSTY7
jZETrCer1nC4dvRudkPvkgB+a8LgPUdb5QwSe5b1T5qgONLIR9NI/8CR81rFBNoz
/64zgmVtUNO3xPe8WD7xRJhX+RVX2q4Rfk4VBeRiKKPuK53fyNsjg/D31kudwqs=
=sMOM
-----END PGP SIGNATURE-----

--PLVMksexArUZ/iL3--

--===============3612839525897626657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3612839525897626657==--
