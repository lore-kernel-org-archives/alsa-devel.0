From: Mark Brown <broonie@kernel.org>
Subject: Re: [ANNOUNCE] 2018 Linux Audio miniconference
Date: Tue, 28 Aug 2018 20:10:37 +0100
Message-ID: <20180828191037.GM2414@sirena.org.uk>
References: <20180810110656.GE20971@sirena.org.uk>
 <20180816160233.GA5656@sirena.org.uk>
 <b735609d-e160-0e48-de6a-a6b36369b7e3@iot.bzh>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8956946997189176235=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D66BE26779D
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 21:10:51 +0200 (CEST)
In-Reply-To: <b735609d-e160-0e48-de6a-a6b36369b7e3@iot.bzh>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fulup Ar Foll <fulup.arfoll@iot.bzh>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8956946997189176235==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uAWY5bLVMBeN1y53"
Content-Disposition: inline


--uAWY5bLVMBeN1y53
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 26, 2018 at 08:33:21PM +0200, Fulup Ar Foll wrote:

> If the room is not already fully pack, I would love to send/two guys from my
> team to this ALSA F2F@ELC.

Please go ahead and sign up!  If the meeting starts to get
oversubscribed we'll try to figure out somewhere with more space.

> My team is the main maintainer for the 4A(AGL Advance Audio Architecture)
> AGL(Automotive Grade Linux) that relies on raw ALSA.

> While AGL/4A obviously target the automotive market, most of the concepts
> should be valuable in other embedded projects that require advanced audio
> config (role, zone, policies/security, docking, mixing, ...) with limited
> CPU/RAM resources.

Ah, another userspace audio framework!  It'd be good to get some
discussion of how to share configuration learing with the other
frameworks, especially PulseAudio (or how to incorporate them into the
same system if that makes more sense).

> Current hot topic for automotive:
>  - smart/smooth integration of soft/hard DSP for equalisation/mixing
>  - noise cancellation and sound bubble (for speech recognition)

These have come up before and could definitely use some discussion with
the various DSP vendors.

>  - sound synchronous networks
>  - virtualisation

Liam mentioned that as interesting as well, and I think the sound
synchronization issue has some overlap with the networked audio
protocols he mentioned.

--uAWY5bLVMBeN1y53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluFniwACgkQJNaLcl1U
h9DF7Qf+LpJIQ87odhI7RzgbRFNceKmL0DrF0G61hWp7svYSmhB5fZxOfwhsUlqv
x2MZvr6cfjZ+RODdMzv4ywH+9ymGbKVqyE8zo4CMEjoyt4y9N+7CZeoYCoXR9uug
c/N1Z0rb49wmbbgB4OzbWsfmrLk7kM0b6R0UmkTTNacdHEn0ORSoXV2FAptkfnUB
tOixSE/NP+f4qOTH+bH8Psi3ye4Ry1EGvmxsBggeJVe8Tktnf/dlGpGqxsQJrx8U
Jd0HUI/bu2gTv4sTl4AYk8VtbuUOU82YVGZd5AQhz4GyE/0PtYQwQllus2+RwFnS
kcYfLJKj9NTqtUM5+OIjD5cQT59wkQ==
=JDOE
-----END PGP SIGNATURE-----

--uAWY5bLVMBeN1y53--

--===============8956946997189176235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8956946997189176235==--
