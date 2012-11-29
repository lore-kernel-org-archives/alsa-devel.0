From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for v3.8
Date: Thu, 29 Nov 2012 16:44:22 +0000
Message-ID: <20121129164422.GM32691@opensource.wolfsonmicro.com>
References: <20121129161015.GL32691@opensource.wolfsonmicro.com>
 <s5hy5hknzho.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2554003640564947049=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2F67F2650D0
 for <alsa-devel@alsa-project.org>; Thu, 29 Nov 2012 17:44:28 +0100 (CET)
In-Reply-To: <s5hy5hknzho.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============2554003640564947049==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vH3HHxf962mwD/qo"
Content-Disposition: inline


--vH3HHxf962mwD/qo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2012 at 05:30:11PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> >   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-n=
ext

> Forgot to push asoc-3.8 tag?

Not propagated yet...  git request-pull really is buggy in the way it
substitutes in a branch for a tag.

> Seriously, this makes too ugly to show up in gitk & co.  I don't mind
> the merge of a few branches.  But, this...=20

> Couldn't you digest in a better way?

*sigh*  I've been doing this all through this release cycle and now you
mention it...

People are going to bitch whatever happens.  You're either going to
get a lot of merges which also causes people to get upset or one big
merge which causes people to get upset especially if you do the merges
as you go so you get what's actually being tested.

I don't really have time to go through and generate a bunch of
individual merges right now, perhaps tomorrow.

--vH3HHxf962mwD/qo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIbBAEBAgAGBQJQt5DfAAoJELSic+t+oim9Kp4P+P5yaW3B2cCJonLoKe1B6FUy
csACpvu6Q6x0ZLgKoxgC3V6Ga9eDUvzJKCOGnNNxHWEfSN3XrBCz9nOSSFPXOTAe
pjH9187nr2IMDWCnRqpBEsaaUyLVKpVQsxgGZgj5DdhTjAsasbnZpjDV7EVd/fun
SVh62s5H6oxlVE0ifOC/cDsm4L3fUDi0zVVdWgRLiw26s2UImP5j4fijxz0HkavT
lyw/lN3aEo5YZgY3KtZIUvtrd40MB3ybDMuJoqSPvFfSC5/kbYUOOK5y+JHYkN66
aLb0S3iEaqza9d6iPoLgd3j0nTWqgG+zxlWRgbP25jbbewAXxqJuVdD8vZTc/edM
2qsI3PIXnpl5PtDyF1bzR6iqVVHEybBe6Ap8YaKHEN3fKNLcQGal2WL9srFG3QJR
zJizUbv7rrapxYofAXcVq33FerfndIhfUbvUv9rYa2qrpE92ReDxAfLi+r1qKHx6
jH8D+X/V0tM4tLK+hJQX4WxSoEdILOidXevnuhPG5n7AhzGNIBNFTg+LY9yl1UZJ
wcvNst96HZZWu8u6OVgJfghp1UBZh0/LXUuMt6ox7oTd+rGTr2TheOqv6lB3wtIK
PTNQGn6HEZtGLKpdz0btt8YmbX9Zk7KYtQ/vntGHHt+S2zY60I474638i0W/zY3H
LAYL879AAK8fW+g8zLw=
=8JXo
-----END PGP SIGNATURE-----

--vH3HHxf962mwD/qo--

--===============2554003640564947049==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2554003640564947049==--
