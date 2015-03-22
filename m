From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/7 linux-next] ASoC: fsi: constify of_device_id array
Date: Sun, 22 Mar 2015 18:05:56 +0000
Message-ID: <20150322180556.GS6643@sirena.org.uk>
References: <1426697344-4884-1-git-send-email-fabf@skynet.be>
 <1426697344-4884-7-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D+M1YvVlDncl3vD5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426697344-4884-7-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--D+M1YvVlDncl3vD5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 18, 2015 at 05:49:01PM +0100, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)

Applied, thanks.

--D+M1YvVlDncl3vD5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwSEAAoJECTWi3JdVIfQDGQH/j7va2VHLh+wn6uyIZFUUgpL
Evv4Lx4kvLX3lezj6EaTKhVJlL/Hp/ChCbB8ABEF355j5mzV9pqkAKAXQ2hH08dM
gyZORiN5QIaAHXXES+zJM5EoXqIOxM9MIlH4Fzq+SWYQaPCsf1FSeA8diiQyVVn9
MNaHK2Yt4ipQggUlP78cfgoY7H11FayWtiEAVRZmnBqAjWS1cODbEXkHnsX5IjbL
KsMoQi6Z8Ig/5UlXhqGTzTSVmKrRTPP38qZtNclRPhubytzvQlCJGRJorEZb6azn
ODYwOK89g9nIvRMuBQDU69pTx+ORcBQ/5GjJUPeEX1eLVkbvNS2hraYeO8U7sl0=
=KpR1
-----END PGP SIGNATURE-----

--D+M1YvVlDncl3vD5--
