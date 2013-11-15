From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: cs42l52: Make MICA/B mixer
 dependent on mic config
Date: Fri, 15 Nov 2013 10:17:14 +0000
Message-ID: <20131115101714.GV26614@sirena.org.uk>
References: <1384451172-1532-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5798637718558015282=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E41226030E
 for <alsa-devel@alsa-project.org>; Fri, 15 Nov 2013 11:17:19 +0100 (CET)
In-Reply-To: <1384451172-1532-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgridwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5798637718558015282==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BrzieSmlpF6NDzIw"
Content-Disposition: inline


--BrzieSmlpF6NDzIw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 14, 2013 at 11:46:11AM -0600, Brian Austin wrote:
> MICA/B Single-Ended input selection depends on mica/b config so lets
> make the mixer controls for them only show for selected mic's

Applied, thanks.

--BrzieSmlpF6NDzIw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJShfSnAAoJELSic+t+oim9accP/jHYbnCQSaTX41qk7slgfoBK
tHN8kQoaHunyXkurjuvNwtc5DpMGE30FqTihBld8jOuQN8C2zn3KJDEf+i2qUd4k
qkEm9oXz4EvBMuEUs4Wp9+yvNB3msbFryJXtk7DbND3iLRP8hks7HIV/9D7kmLce
K37qaNhmHzWkGZn1WM0CpG8T6L0kCi3J2EEHqKha0ZVf9KOb6SE+VYHGUKLfumhA
UuX+CRLXlzaMd00mZyVTdK+qc7s/pQ/XKEVzhvjB2iE7u57pgxlS5HG5GboyviS+
mYH5ut/IDYazQrlNrSOg818lHNoWEWnd4JvdAwaUPId1O5Fnum3ap/9t4BpffRnV
a3X06NmCjPuBQUM93W5BjUGKtFQ/5XCUqg7GkhPKlLpniz2hpufbxeZ/9PyPww4y
zLjUEyTem9i7a5+4czPj9P/mnf2kBqAMQkxqHZUHlz8+YH+i0KGmuAtizVAtvy/u
r5wAeLwru1igLNnzr2OLVA7LTLbx3Oikl7QT6J1rlYMmgtDX7L8oZ1u/RfAgEkP4
1z/MpiCOUwOXjE4U0NTpeGHEouCekdmmzamF0IsDZ6Wa7f+1b/PvW6/6cm4KJNkq
sZGTCJH717h/EzZ1gdtVYWHHxiMfpzjuC2tKBAnxGWwSJCk+8KhlijCjdmj80ynx
t3iz71VEvyXBoOiv+ed+
=TNnT
-----END PGP SIGNATURE-----

--BrzieSmlpF6NDzIw--

--===============5798637718558015282==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5798637718558015282==--
