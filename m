From: Mark Brown <broonie@kernel.org>
Subject: Audio Miniconference 2013 schedule II - Edinburgh 21st
	October
Date: Mon, 14 Oct 2013 17:10:03 +0100
Message-ID: <20131014161003.GC2443@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6246955474675148392=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 852EE262607
 for <alsa-devel@alsa-project.org>; Mon, 14 Oct 2013 18:10:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Colin Guthrie <colin@guthr.ie>, Takashi Iwai <tiwai@suse.de>, Arun Raghavan <arun.raghavan@collabora.co.uk>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>, Tanu Kaskinen <tanuk@iki.fi>, David Henningsson <david.henningsson@canonical.com>, "Bossart,
 Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============6246955474675148392==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cUq9BFDytUJq8bQY"
Content-Disposition: inline


--cUq9BFDytUJq8bQY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Another go at the schedule for the mini-summit based on the feedback
last time.  Same three major topics:

 - Compressed audio review: tinycompress, integration into userspace,
   driver upstreaming.

 - UCM and other use case management status & review (Tanu).

 - Effects offload to DSPs with dynamically instantiatable algorithms,
   and general dynamic DSP firmware handling including DSP resource
   management (Pierre).

Plus a few things that only one or two people brought up:

 - Process stuff (the list, bug tracking and so on).

 - Some relatively specific hardware support topics:
  - HDMI hotplug handling throughout the stack
  - Mic status LED handling throughout the stack.

 - Code cleanups:
  - Moving away from the custom ALSA device registration infrastructure.
  - General code modernisation.

 - Performance, especially DAPM (Patrick)

 - General routing control in userspace - UIs, automation (Daniel).

Hopefully this caught everything that was missed last time.  It'd be
good to have volunteers to lead the discussions in each area, I've
marked those we got already.

As previously mentioned it'd be good if anyone planning to attend could
fill in the form at:

 https://docs.google.com/forms/d/105uav9tkwwkDU4P1T3IOWjfsa3kgtDbFAJOlHgBQR5k/viewform

to help with planning & coordination.

--cUq9BFDytUJq8bQY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSXBdYAAoJELSic+t+oim9w+MP/jzhQz4yvHIG52OgiSBfi3Ri
OLVbuJkbJbXqIu8LNjgczTPQZPJfroY/qvqMOgKij6M4RMi5SUU2oMfxkzFScT/f
HItRhF+ls4aFEZUhPTxN20FW3F7fjjByqfyAwGTsXGT3c6AuO2WY4lNWUKiN9lI1
M6710lSqm9TZgljtRpznE2KhcyMWZr3jfPJpTnLCNybfwIHLD/aAJkdQZs9++LZ0
1sWBjDGbUbgbaCEEpgiZBXnwd0/j97ORM066o2LDPtRH6LNGcCMic3hshvOV9qsu
YZ606gtfBFnUC08ejPhFHnsU7mrFOi8cNHf0Tm45KFk03O8X7UWoKuplEwFOnH0N
rZfFNg0q3ePdkyXCgoze/zZupRamrhy5ExEzVD9DFuq1EDwQ0d8BB1N24zpDww2s
CDJKr41OVkcw1dWRis8FmLEDm8jEkQz63krtqcLfq9yUzR3FXpaepjR7Sf0tq7kO
WzUsjL4ZUZayFpfrSbE55Zzr3debjUbplmMb1rGfWB7eOIxUMACOiuA3DIj86eOz
Ro7J3YG3uMbegzdV/nU2aPB8d0qcraeCLnr5TTxUsJ0l0ogYohKcRHFqQ2uTU/n3
2BlKQmsPjgFxGT/35N11qnaXxJ47XduSK+6ZpLDAwr3qbz69j42RJh4lHoUh7TZJ
9OII8iWMgM0gOMIrnhEG
=K1vU
-----END PGP SIGNATURE-----

--cUq9BFDytUJq8bQY--

--===============6246955474675148392==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6246955474675148392==--
