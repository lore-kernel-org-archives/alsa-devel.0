From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 0/9] Add SKL ipc handling code
Date: Mon, 20 Apr 2015 22:44:41 +0100
Message-ID: <20150420214441.GW14892@sirena.org.uk>
References: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7081166987353318618=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BCB62654FC
 for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2015 23:44:44 +0200 (CEST)
In-Reply-To: <1429276567-29007-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============7081166987353318618==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3jK+0sHr6j/jwA0V"
Content-Disposition: inline


--3jK+0sHr6j/jwA0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 17, 2015 at 06:45:58PM +0530, Vinod Koul wrote:
> This series adds support for managing DSP and posting IPC and processing IPC
> replies.

Any dependencies on the generic HDA stuff you've been posting?

--3jK+0sHr6j/jwA0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVNXNJAAoJECTWi3JdVIfQy6gH/i1Ypwm/9In0wgjl2JZTc40J
w3fcKeCRlm5k/37lVyEQeO2xKizAZidAzHOv+QekQXdd8mGDjTwtqLeNU5p2TDfd
FySqzTa9mC04RC37PoDk6nCFMJEn/X14ySNkBWyro8F9PAoSkXU9gmNgy3aBqly5
ApEoY0NMR17uZDhmsA8dpUVU7PeQjVFlOr4qrfq4PEzsL6LX/0B6gozh0zW3ifae
IHbZ/8cWEeL0iN4zgrljGJCtmFVOG2ljAsGvFE+z5YRZEg4Q7ACKStIgXonQ9DIu
Rj6oT3QPwL822R6sE5WVbooch7/9pv+bVc3EPIVFGZb+Ufxlo/WqRLYcwysdgfU=
=pkvZ
-----END PGP SIGNATURE-----

--3jK+0sHr6j/jwA0V--

--===============7081166987353318618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7081166987353318618==--
