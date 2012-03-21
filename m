From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question: PCM short and long sync formats
Date: Wed, 21 Mar 2012 11:51:46 +0000
Message-ID: <20120321115146.GC3226@opensource.wolfsonmicro.com>
References: <4F69ABB0.2000706@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0477184680810505624=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CEEDB24569
	for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2012 12:51:48 +0100 (CET)
In-Reply-To: <4F69ABB0.2000706@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Omair Mohammed Abdullah <omair.m.abdullah@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============0477184680810505624==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2012 at 03:51:36PM +0530, Omair Mohammed Abdullah wrote:

> I was looking for PCM short frame sync and PCM long frame sync, but
> they are not present in soc-dai.h (FORMAT_MASK). Is there a way to
> derive them from other formats or should I just add them?

What do you mean when you say "PCM short frame sync" and "PCM long
frame sync"?

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPacDMAAoJEBus8iNuMP3dVyUQAJJU2/4V8DYfjUtyPrXHbWeq
Lw4AypLrwDiG/HvyyPJYLJOueadpjczyzNUdRJ9j24MB8IxtAKBrgbmlDUKdzMXq
Kjspomggs80LcspUv1UI+h+izmnzmXjYKqhbYpxsh70ws5pT0ubOcLolzrUSwUdW
smWxpOjYdr82zBqK52z1D4OOy5cRxM20lboli0LutxZpzDIfYGvIj2pFCHo+spmm
4uqDONf0vZhO1E+BvsbAVS3PS8Xavm0NS+05h89FbmbbNkQV7A8CRE+vo8EvJwoV
e89OzmDlM1VyQwcr8fP6Z5b2xzdA6sgyE8t7BmqK9QvqQxt7zMouGdAGJmqtMHen
09YVWjcOi+QWjtH3xNdXCHPQkk+7JUvkZqYAp2ZzzmzUrCCH6ozCM74uu14g9dD9
obgKR7FMBs2LgqfX4h+0M3jWGRtwZkNHcmOl7Do5rQ/HEBiBF63s5zdTWJqP+NOW
dj0exC4Lh+bPNUwTDyu95Rz9Porg/vXb3oNIxeNciwo4sXjMllQoRDxSCvRHZ1mf
zVWxN0JAVXzbXHgbJyNXuP06oEQsy/9OMbdX/F41G0WoI/MkwPyrXymHr45b8T16
rglFXQRkEbarQ7SVNhkHpxnS/8hjpvd9p1wbUAD1wsDH6rdNj/CDBQjEYOQQiory
b8m35Z4dBObaKFDddB6Y
=x+pp
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--

--===============0477184680810505624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0477184680810505624==--
