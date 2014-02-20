From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 026/102] ASoC: wm8991: Fix the wrong number
	of enum items
Date: Thu, 20 Feb 2014 10:32:10 +0900
Message-ID: <20140220013210.GM2669@sirena.org.uk>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
 <1392723422-12689-11-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2113546791031498813=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6A0DD26537D
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:32:15 +0100 (CET)
In-Reply-To: <1392723422-12689-11-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2113546791031498813==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y87zqFmoGECkYaVu"
Content-Disposition: inline


--y87zqFmoGECkYaVu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:37:01PM +0100, Takashi Iwai wrote:
> wm8991 codec driver has a few places wrongly defining the number of
> enum items.

Applied, thanks.

--y87zqFmoGECkYaVu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBVsXAAoJELSic+t+oim99mcP/Rf0uAmuz5/Rd4hw9tpgnSmr
ndSKDrTkZbJt30JVeSQyVHbNsdn1jjwU72YVnhf0L5jQMFavNh40e9D3YH8zV4RQ
mCDXzWpftTVFT0NqVcfjB9n3TcUjUJ8gHJWaoBNzkQQCFQ4OWLtsGtoUcf0T68op
KRzmJybInDtLUl+xvF9p358xd0bverHuvTG7vB0wpQdA5qMMPwMwh1VDUw0kU4OO
hvNpo7VN24MTsGg4oNPAqKXlza1U+UT1vCRK5flt8gutN4KP9+IEkLhjMdmFArTQ
bzVJ5W+kf7gPQLrur1GmznzdGq/sCneqn27hf0Men1ZBZurHfUNnRIGYNKb4se8j
MT1TQaOmo1ByekZCbE6ftY0Gyz4wmwRo98NOJJMcUTnBdfAPJiP026bHIufk17kn
BQeJhbW4naS0uKbWDgnkaU8HFF/GjLYVmC1jsfaMWkcKKT6nHfeDftynIU0uAlG4
3sHEzd+M1SlCpwjGWCMh/n3K74jbMdDtRUgIJwZvK2IuGgioTA83ttEUQ5Ix0/Ys
gm8F3OGTObBiNyBCHIlktBTF5OaC0G4HnGuzT7xsatelPKoTF0Dh7bvn5UOX+ayg
phSwerQ/QxzSYdiBlaeUcTHTDweyo6XACP/JEprhEvDRA/Lh97IihDI9UtfnLvcu
HKKEd1oxHVL9ku4HWFWR
=wjOh
-----END PGP SIGNATURE-----

--y87zqFmoGECkYaVu--

--===============2113546791031498813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2113546791031498813==--
