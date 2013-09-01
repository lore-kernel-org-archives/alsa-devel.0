From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/5] Remove ASoC-level I/O functions from cq93vc
Date: Sun, 1 Sep 2013 16:08:53 +0100
Message-ID: <20130901150853.GG3084@sirena.org.uk>
References: <20130831130741.GG18608@sirena.org.uk>
	<20130901144847.GM20329@zurbaran>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2001378892=="
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <20130901144847.GM20329@zurbaran>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Miguel Aguilar <miguel.aguilar-9uBrGCPFOa1Wk0Htik3J/w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

--===============2001378892==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6lXr1rPCNTf1w0X8"
Content-Disposition: inline

--6lXr1rPCNTf1w0X8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 01, 2013 at 04:48:47PM +0200, Samuel Ortiz wrote:

> As I'd prefer to carry the MFD ones (Including the twl6040 one) through
> mfd-next, I can build a branch for you to pull from. Would that be fine
> with you ?

That's fine by me, I just want the patches in ASoC - obviously the
branch couldn't be rebased though.

--6lXr1rPCNTf1w0X8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSI1iCAAoJELSic+t+oim9+b4P/i1410dDEXX6TJacGtOVBIsk
oUB0WdYEJgyxoiAyolJhkDRzbjrYxIH8HomfjjCb8pTHVUkEmM7a4cX58PDmuXMR
BFAq9Ov0nrLAzBeq99mPYrWLRkSCBac5hAMjliCHRKNwJEqLimV3338LD8MdwuzQ
790r1iyONKkCr1Vub0EdwdTt1zthP1hdF+wNvv8LmTU9jnKfULlOaTTK6+YXfGun
vZQ2/ljPkBQNyeV85IdGwn6zmwTLcgX0v5tHykzOs6G95m1rQ20IBkf8LwkIuGE+
ODsVtwhESStuws6osMIjsciiJJXVDaJW9mnc1YZPk1q4NEkGlCO72cKLHwGxvXH6
uvIRxOtJeCPl9xIUweRBaIMtrdRoVhZEJOSXNXKHBWlIJTn8OU8I7SPlT/kzC54e
VIfD3WOSGz6KRUErefKaCSWJA1aCQdIZjwJDfonaVvGFtORYMlPrR/Fec/A2vDIo
QXxqNuu5YxpfCFwmE/8AYVzo6J5V4lzx6MRfElt0lWafY/hnXONI0Ql4OAHJrfe6
qo5XLkR9ZqcvWPr7KFLY6qgdlQxQqLLpbhyvGuNAI9M0ktdXSdv6RQjNGLcdMhLG
15EDmGBb2y6hkU6a+NVaUF185AlTVuRuaVEBhwuUwb1B4FcdOQji6wOPRtXdaMNE
PD3u2ZVN+Iv9RBBBdbe1
=zyny
-----END PGP SIGNATURE-----

--6lXr1rPCNTf1w0X8--

--===============2001378892==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2001378892==--
