From: Mark Brown <broonie@kernel.org>
Subject: Audio miniconference schedule
Date: Thu, 18 Oct 2018 18:55:15 +0100
Message-ID: <20181018175515.GB8291@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7267463260420597053=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5283B26751A
 for <alsa-devel@alsa-project.org>; Thu, 18 Oct 2018 19:55:18 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org


--===============7267463260420597053==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wq9mPyueHGvFACwf"
Content-Disposition: inline


--wq9mPyueHGvFACwf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As previously announced there's an audio miniconference happening on the
21st in Edinburgh, meeting around 9am and getting started once enough
people have arrived (Cirrus people, please let me know if we need to
start later, some people have said they'll be arriving late so we won't
wait for everyone):

   https://blog.sirena.org.uk/2018/09/19/2018-linux-audio-miniconfernce

(yes there is a typo in the URL).  A number of people have proposed
topics so I just went through them and pulled them into a proposed
agenda, revised again after further feedback:

  - Introductions
  - Community governence issues (Takashi)
  - Virtualization (Liam)
  - AVB (Liam)
  - Testing (Takashi)
  - PCM improvements (Takashi)
   - Granularity
   - Timestamping
  - SoundWire (Liam)
  - Integrating the ALSA control core (Sakamoto-san)
   - Obsolete 'dimen' member in container for information to an element
   - Remove limitation on a container for value array to an element
   - User-defined element set left by finished process
   - Expand restriction to the number of user-defined control element set
     per sound card
  - Another approach to produce language bindings by GObject Introspection
    (Sakamoto-san)
  - ASoC rate domains/core refactoring (Charles)
  - ASoC/ALSA core merging (Takashi)
  - DSPs (Liam)
   - Sound Open Firmware (Liam)
   - Byte controls (Vinod/Patrick)
   - Calibration loading (Patrick)
   - Exposing graph at runtime (Patrick)
   - Batching commands (Patrick)
  - AGL (Stephane/Ronan)

I hope I've not missed anything people suggested, the schedule is now
looking pretty full but I'm hoping some of these topics can be
relatively brief.

I've dropped Y2038 from the expliit schedule, since Arnd Bergmann (who's
been driving a lot of the general Y2038 work) will be in Edinburgh and
may be free to join I'm suggesting that if he's free we cover that
either first thing or just after lunch and otherwise Takashi and I will
try to coordinate with him during the Maintainer's Summit on Monday
(unless others have a great enthusiasm for the subject).

What do people think?  Any other topics?  There's still time to sign up
if you're interested in attending, you can sign up right up to the day
of the event though registering early would help a lot with logistics.

--wq9mPyueHGvFACwf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvIyQIACgkQJNaLcl1U
h9DCBAf+JllDrX14Hhj0Q8gLVFmcCgZN/VynsrlTuH0/5SrW8Zlk2LaMObpXVG2v
bQ71s64pnUx9FavAZGD89i1vIG3AnfkPiLHn9JsK35lny26qZ/50WOIGmMQD/SLt
jULWqtdPNx8ZeFASgJOn+FSvlXK9EfZvUKQxRjsFzX1QBTNLm8vSTu5mLzW/qRFp
40Hm6YmAeIRgAAcYQcwH/K7Shajo7weHnHa5NB1d18R0cPHFcV/GjB2uxYDg7PhR
z4A/BkwUgHjNkG4DDahdCBKbAbOdsbwpdLAuHxwYMOXs1WZnaChpYufvnnIn4gIb
VUh/il6YnTIERwbrLEsbokQ53zM6mA==
=XlJY
-----END PGP SIGNATURE-----

--wq9mPyueHGvFACwf--

--===============7267463260420597053==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7267463260420597053==--
