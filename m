From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: soc-dsp programming model for loopbacks
Date: Thu, 2 Feb 2012 12:06:02 +0000
Message-ID: <20120202120602.GB7428@opensource.wolfsonmicro.com>
References: <4f1f2489.c602440a.208e.ffff9d7bSMTPIN_ADDED@mx.google.com>
	<1327511249.11901.37.camel@odin>
	<1328087231.1610.28.camel@vkoul-udesk3>
	<CABS+qY2GADPO+wkmDf5hzT7uaH7v1zNrdAGKnLbip-QAL8V_RQ@mail.gmail.com>
	<1328181472.3974.5.camel@odin>
	<1328184200.26182.8.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8820839445578219136=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 847B1103867
	for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2012 13:06:04 +0100 (CET)
In-Reply-To: <1328184200.26182.8.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8820839445578219136==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2012 at 05:33:20PM +0530, Vinod Koul wrote:

> And Mark, can we see your wip changes??

No.  I essentially never have any WIP changes, anything I do to the
point where it's actually useful gets submitted to mainline pretty much
immediately.  I did do some stuff but it was too horrible as it was
trying to figure out the hw_params automatically and this was causing
appauling pain, underlying changes have bitrotted that away.

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKnwjAAoJEBus8iNuMP3dpUgP/RegXWUbA7WitMYv3RNCIurG
GbhP9xWFNsTYsybwTCU2AHd+OhqNhQp0AD+8LwLjvs42B82l0Jd0JNdvH2N88ggD
CmJPJEAjYw6t2EYZ99Fuiwts9uiIZOOzI4+4fNbOT1efCaSELOdJBBP6TiFA6mYc
C2x0XL700eNoC+brzbdR8tpdciYQqg9TPp2+yPt5QhMZBXF0tfT3Rm/o+ugmMXJT
jhES1AtrHXTqlfn0KHL33CdlPJ9SCW0Rw0qUzjDvweSjDpQkVJYDLEcxA+i0IdCq
rgwqhoh8aAsD5ipJOVcHGB7J3fsJd0HSltAeBhbfzVWdORghHh6Y1KYxb8/mj/lM
+sGJNB3k4lk9QhmaFRX3a4Ra1WCJdgrVxfO2zAPxBGjXcDztqMNG0dL/REx/hlgF
Rh1eTth7S1HgBYru9QAzX57gcVtnN6HIOEQGKzVlvlTn0H/AD3y+cIj6JgffwMsN
TaVAL2Jaah4aOEv1cZ0f9PMZG2hr8IpEveEX2/Pu2VciVHNw/l9OvCDa82RmBoly
8m4M6DTMqnHRmdxZAExLNvmzUhwpvhc3yViEc+lVi3pQVRkrzrPRkePTYFrztqJJ
HALdEbZSfyFEUgjamVrklJHDzKwbImxDwdMNkoHtSDwzdbncQw6qUkgY1pSFXzCI
5HP/HDE5XxG2fTCx42cz
=qfte
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--

--===============8820839445578219136==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8820839445578219136==--
