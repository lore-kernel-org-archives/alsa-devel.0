From: Mark Brown <broonie@kernel.org>
Subject: Re: USB sound auto-suspend not working
Date: Tue, 17 Dec 2013 23:07:00 +0000
Message-ID: <20131217230700.GY28455@sirena.org.uk>
References: <20131217225548.GA3029@xanatos>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4463183635325764462=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 730AB2610A7
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 00:07:04 +0100 (CET)
In-Reply-To: <20131217225548.GA3029@xanatos>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, Oliver Neukum <oneukum@suse.de>, linux-usb@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4463183635325764462==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F41/6/O0EvKTfNqT"
Content-Disposition: inline


--F41/6/O0EvKTfNqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 17, 2013 at 02:55:48PM -0800, Sarah Sharp wrote:

> I plugged in a USB speaker, and ran lsof to see which files were open
> (output is attached).  AFAICT, only the USB sound device's control files
> are open, and I don't have any midi files.

The attachment seems to have gone AWOL (at least on the list)?

--F41/6/O0EvKTfNqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSsNkRAAoJELSic+t+oim9HEAQAJN6GRGoaI/zSva+DVU/lnBX
hCOM4pbH++p31UGZMxY7JMeMHy9oPnboOyTBfzRXQKmaQEClR/UoMLEM+tmlwj3o
RNV2cZbpxswYEXgwZy77BGPJ6De2WMakJL46PKZ1nUqADSGPx9tH/6/XUeoHX76C
mvT8mHEeXp+zcuP2frnvxGbqPcejOyjiQcU0OS86xk97bon2SO+YCTp931ChU3U1
8Iw4t4iXAtq/keKr5X/ScMhaKB88b7a7cvEX5Lq48VFgQcyKwHnShoe1E02e5YPi
yUjolB0Xr5+BGP1RWEVqsy2+ehjisL4HMHar2Q4kegF2HOfFQvoJW0lEKqIiOua4
n/1AViXWffq1/l1/8r8yFI2WS98/KinZj5zgqrZtjmn6oxFtTMJs6sg3fmgMy8yb
RGh+dFSYxKQ1GHzVeMT1AUlCnkPmbG7veJkMeG2SObcyhheeGp1nFHAkVnYiL13j
vS27X24e4pzF1A4itmoK8IXnl/zts4Kyo97tq8nqi83buxkTppYSrOiMxyFPW0kt
ksOopEqCheuZ6ppmeh4u2jiWqjXXOy9nJzDRBCHm+WB6PzFiCHSUrrOviVN6j2ES
vY+9J7yrW8jNPR7nA460dPF7sWr7hFPcb7VpdQPaHOfV1DRAjldxbbYLvQCqJpdG
OIAQ2ESsc2D7q2ubwzFL
=Mjzx
-----END PGP SIGNATURE-----

--F41/6/O0EvKTfNqT--

--===============4463183635325764462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4463183635325764462==--
