From: joshk@triplehelix.org (Joshua Kwan)
Subject: Re: Some problems with snd-au8830
Date: Sun, 12 Sep 2004 23:19:34 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040913061934.GE12433@triplehelix.org>
References: <20040912084204.GA22712@darjeeling.triplehelix.org> <1095015988.2056.9.camel@localhost> <20040912215450.GD12433@triplehelix.org> <1095050630.2193.16.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1095050630.2193.16.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@users.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 13, 2004 at 12:43:51AM -0400, Manuel Jander wrote:
> Oops, thats very odd too... Any chance to record that and send me a
> sample ? Knowing exactly how it sounds, could give me a clue.

I may, if I have time this week.

> Hmm, is that a 64bit Opteron or something like that ? Kernel version ?
> alsa-driver from vanilla kernel or compiled separately ? How can i
> reproduce your situation/scenario ?

Nope. It's a Socket A motherboard with an Athlon XP 3200+ in it. Version
2.6.9-rc1 (although it started happening many revisions ago, possibly
even when the driver was first merged.)

> You should not need any .asoundrc settings for hardware mixing. It works
> just out of the box.

Oh, maybe it used to be different, but I didn't find that it worked
until I did that.. I will experiment.

--=20
Joshua Kwan

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQUU79KOILr94RG8mAQLeQg//VE6pu36Cg4qhItprklxX1bB+BfxjAbJy
SGWfPyqrVbwe1lOUmZ/BRLtPh/cot9JNm/cF5n1sHb+a1kffNBP4G/YGD/52/kMn
IZnOos7I53CRdVj2rcjvTbN3XsO5LuD1gfmLqWSzIcQCccDMXX37XX5mQxE+rP2l
RyKXanx01CKb4eNY5GgQvMB12pMGxHKm2KKlTPw8DYJkhLRU0ar58jksWgSaYEUK
f25VefexoWNhnESiZhoaOJiTHWxI/Ce5Xj4jOVW49Wg4YBZwMc/+Js5Hn+CqK1DM
FJ/dbaeVf0b/4ZPkrUM01mJc3xpT5S/uV4+5ZhqHbpe3+8ueZ8sSTaHwO+tpsiMo
f8qkLWG8VbXJ11zMKFfLf3Bn4qbcA3/iqmdHlRYoL/J09x5J2q2L+pcm3PbnAZed
y1VjhccZur0u9x/sOhG4aeaLEq9rlNvpPUG+BQo6prkGW/bbMbiU3wjFI+3evlHF
vjKFZdw+6iPPuR5dI9r3WvPOxnycUE2SLGMoh2+m39BMQcd+AlvEBixm/eZDvVDQ
uyil7jumf4bFt+8wFTIe1AqiPq/H08NZg6MrqNvBCKOROxkcT1X8J2PywGFQrmRm
fv8xuW6D8tlzzl1qDq4KMmdGy8u/BLqRxTrS+D/2EdXB1dxl7cuiVVS5fKGkwm3n
swWJgzmifmg=
=9X4I
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
