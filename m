From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Intel: Check Haswell IPC
 process_reply/notification return value.
Date: Fri, 7 Mar 2014 10:51:18 +0800
Message-ID: <20140307025118.GW13126@sirena.org.uk>
References: <1394117766-7242-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9066656200996016347=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CD02026591C
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 03:51:30 +0100 (CET)
In-Reply-To: <1394117766-7242-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============9066656200996016347==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I+ctuiCfVAvadeQ/"
Content-Disposition: inline


--I+ctuiCfVAvadeQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 06, 2014 at 02:56:04PM +0000, Liam Girdwood wrote:

> Check the return value for error when processing replies and notifications.

Applied, thanks.

--I+ctuiCfVAvadeQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTGTQjAAoJELSic+t+oim9LgwQAIHatqT0qK1JjRgLSi/FcV9l
zgLIMR4zxwldqt2aeuT8rC+Pao+pe1Fb+X/2rrO23S8G+gl4TnLBXBVYPhyjOFP7
Vz2oHjMbrHlzdPDObqJOLTXyQd4+0T2HQkDzi7mfQAWdcLHhSAc+rNe/w9GSgqcb
6+aOmQQRYgsy4ymr6duuPdtB9rPM0IfI3wYXz+aClso0mgYaZ7fq+5cHbbrtk0hR
DpdJnv9Bcom7B3y55VWawkG96x1s14lhuL0qQZg2OKRuV6lk0QxUX/cWxaWUAfJH
qINjOiDrJGQbDKHh1CMuVXfuXY/wF9PItSaUiYvczroQxRbR605Ey7jmi6FMeWDy
RS7MU84d7kfIe1LpGWfhSYUiLWg5d89gBdA5LwNv1e2iEV5vLGV3kYtlkIiFQ5wJ
vVc3aRyXAAoUheL1/DT33aD0P0tUy587znxg/DDtBDviMRgNpwgjVO4dEw+e1PvG
XhN+Ct67EztRgPfNxMIvSKVGUoYc1l8DYh+zSClecyBuXHCxlZyUimJ/EXfh4dTG
86x35UNoqS+YZPMRJL8Wnz8+2D4DYDFhp9Hs5l141GVPdFmAdfJi37r4L0VyeQ4x
YTFndpe2cBXTrZoqLl39YjNKgiE5WPNAgYHfHlBIlSbpRTWy1OmH3xQsQ4QvHYf3
+9Tb9UE2ivPYiT1FDhX+
=jgnn
-----END PGP SIGNATURE-----

--I+ctuiCfVAvadeQ/--

--===============9066656200996016347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9066656200996016347==--
