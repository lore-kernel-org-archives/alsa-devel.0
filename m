From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question: PCM short and long sync formats
Date: Mon, 26 Mar 2012 13:08:53 +0100
Message-ID: <20120326120853.GP3098@opensource.wolfsonmicro.com>
References: <4F69ABB0.2000706@linux.intel.com>
	<20120321115146.GC3226@opensource.wolfsonmicro.com>
	<4F7031AD.3090202@linux.intel.com>
	<20120326102650.GC3098@opensource.wolfsonmicro.com>
	<4F705BF3.5080905@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5728969209372000634=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CEE322490D
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Mar 2012 14:07:19 +0200 (CEST)
In-Reply-To: <4F705BF3.5080905@linux.intel.com>
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


--===============5728969209372000634==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N5iGxCIPT7YMRg16"
Content-Disposition: inline


--N5iGxCIPT7YMRg16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 26, 2012 at 05:37:15PM +0530, Omair Mohammed Abdullah wrote:
> On Monday 26 March 2012 03:56 PM, Mark Brown wrote:

> >I'm sorry but I still have no idea what you're talking about.  You've
> >described PCM mode but not explained what "short frame sync" and "long
> >frame sync" mode are.

> This diagram may explain things better:
> http://picpaste.com/pcm_fs-7dBlrkuW.png

Sorry, that's not really clarifying things.  It looks like "long frame
sync" is just I2S but presumably there's some difference?

--N5iGxCIPT7YMRg16
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPcFxMAAoJEBus8iNuMP3d3NoP/R0sm1MbrSB2jD1UCw1JvVWL
3jIck45s7lqwSNqzrnzXziHuZ3SCBrHzR08tzDsd2hkfPwS/UBooo5+5o++3sOsX
B0cL0Z20ujksk6oq0X9rpUmh9kCD9vWaoR1DPFRu22RZW+QmwsJ6z3Mwfu3cN8JT
dfXxQcfTIk8aQgpRvnfvcGXTVLfG2h+cxLPWsaBtZwP6TyxUeNnK5wrkDqeAMdjS
DXMvgtgqnmSV9n+AYbUOQzR6Lf2z8+kWgyL7+9PbYYBdyW6ltWaL3wzsEHv1K7K/
XeLfrN/qcrPVUQ68LU2IWNXbHQkMwzk70nerD0PBOtHlz0uSQC9GK9CXQe22KOtz
dTwRUGprj3uTjU+M/CITWeD1parGOvFEU53kqFJkbobU+/JZHgZgcScrj5bpY2Dc
hV2YGL5K+hrzSIdlini2P3m+uiqQZSbbnsBU9gzF5Hb1V1rANVPG3oC3XzJ5PNZP
WDQ6E+DaUqhvZmW8BfC12jyo1zxQvLr/Fv9QSSmn5kuph3DPYAIFTH9+RRpUtuDc
DtmwkCTm8rMmtPnkeeKGIIMTCppDAjDmPmEiMSF591yTi0NIESEwFSpXStPVC3aw
qCLF6yWV4HPVGhuwgdhRxevqAdtWA9Wd6fq6TDYFnJQA/2zBf9NPD/3XVEd2fHrI
DZz1XXNeQHZ0gf26LxtI
=U1h+
-----END PGP SIGNATURE-----

--N5iGxCIPT7YMRg16--

--===============5728969209372000634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5728969209372000634==--
