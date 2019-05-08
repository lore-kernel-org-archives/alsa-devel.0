From: Mark Brown <broonie@kernel.org>
Subject: Re: Fwd: [PATCH] ASoC: SOF: Fix unused variable
	warnings
Date: Wed, 8 May 2019 19:13:02 +0900
Message-ID: <20190508101302.GN14916@sirena.org.uk>
References: <20190508085037.24773-1-tiwai@suse.de>
 <s5h8svhnx96.wl-tiwai@suse.de>
 <20190508093249.GJ14916@sirena.org.uk>
 <s5himuls28b.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7888769540800182723=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 81571F80796
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 12:14:24 +0200 (CEST)
In-Reply-To: <s5himuls28b.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7888769540800182723==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aaeYxw/B9teUOk8U"
Content-Disposition: inline


--aaeYxw/B9teUOk8U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 08, 2019 at 11:51:48AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Forwarding stuff doesn't work with patchwork or with git am and with my
> > scripts using patchwork if things don't hit the list they get delayed by
> > several days :/

> I mind resubmitting, but I thought it would mind you.
> OK, will resend in such a case at the next time.

It would've got applied after a few days either way, what I'm doing at
the minute is saving patches I want to apply to mailboxes that are then
applied by a script.  If the script can't find the patch in patchwork
it'll give things a few days in case it's been held up by moderation on
the list then apply it anyway.

--aaeYxw/B9teUOk8U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSq60ACgkQJNaLcl1U
h9BndQf/cCPTbRUULTpljkmfkQQIr6F3UT2SvBSLtDB457CoOM0yeHLu3od6mO3l
SM8G1Fck0C09w/BHCwP2wQLnruMAlJHLJuHAt6q7VU+8OKddWc0heLAJifRXAjfC
9qw9c4/7h604Do8TCEFvNV53TjpDwp3+h91TjbB/ipo/7Kt9AouVK2Jv6i0PVMGe
9NC5Dc/hE8T6AWFCRoPiy6fZYROyiof3WFkOqACMEsLJAmCuqQQE8Vzjy2cWhP09
nVVdIK4t1vOprDzcggIs+dS2VnzPzTjYNyXepsmlS/pk0jCZj5uvw3GhAtcreuMM
8pUPckBIxyzYcKOlwrSxvVgYN3o3Bw==
=SK1u
-----END PGP SIGNATURE-----

--aaeYxw/B9teUOk8U--

--===============7888769540800182723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7888769540800182723==--
