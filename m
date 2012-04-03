From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: core: Initialize err for
	snd_soc_put_volsw_sx
Date: Tue, 3 Apr 2012 20:30:07 +0100
Message-ID: <20120403193006.GA11910@opensource.wolfsonmicro.com>
References: <1333470830-27137-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5794551090790938456=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2A0B3103B49
	for <alsa-devel@alsa-project.org>;
	Tue,  3 Apr 2012 21:30:12 +0200 (CEST)
In-Reply-To: <1333470830-27137-1-git-send-email-brian.austin@cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============5794551090790938456==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2012 at 11:33:50AM -0500, Brian Austin wrote:
> sound/soc/soc-core.c: In function =E2=80=98snd_soc_put_volsw_sx=E2=80=99:
> sound/soc/soc-core.c:2600: warning: =E2=80=98err=E2=80=99 may be used uni=
nitialized in this function

Applied, thanks.

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPe0+yAAoJEBus8iNuMP3dz04QAIqzQqXy7In6BbUv6yTVErko
BmddA8DBc0WF3n9wf34OaO0UFBo+H4wIUb7MvtLpdE7g9f/20Xu7/cOdKKSpum2K
k0L8xF+NABc5oSJFpgWsS13qeM/WeQ866LsQki/1kte2MstiuravNK+QJr3sQPKf
lglQuuvfUZjU0Qldut90Ly5NaQDzKntT6kIVR119k9CWz38romavnHB3PPVfXwAH
o9jKqXXdRNJ7zsn3GmiVjUNnSbIrTAnYZS/9tBvJJ4ol9RK5qKUxwnSnBIEwOCsn
jFDPwHJcYw40xQYPWGh/FeumZd4F0eK1OpPRb6TjJ3BR/ZRkhXXAeuKMjER/G7Vn
mUwWRbf5uu6hbE0UQXrUYPPzl4dQlVpg0BU41C0SFtActu6ld1O4R7x1uQTmalxp
uFn0AAnLNPpBzioCFqj24KSxZNzQu90u0qX1IjX7gokb4My3mFonNyJKhho67F9O
gcTdZGbDlSzWzMOfOfzLziHvfw9L6JF1EztHXYKAiZIaHIRrWn5J4kSMOJ4zRQDH
gwyGMANCgBtzdZ1LuMRn3WpOEpGjw8EaihEpKl17gfJAkxc8/F1nk96rlGNMZ+lW
Lzy1N4vQOW7IADXY2jvIinMFmCB0t4KXVrYqDGZ48gYzlxNT4R//pvM7671Mt63Y
CBg81Nnmng/DD0Ju8Se5
=sYLu
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

--===============5794551090790938456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5794551090790938456==--
