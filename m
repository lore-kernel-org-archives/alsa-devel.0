From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc: bfin: use dev_err to print error log
 instead of dev_dbg
Date: Thu, 21 Jun 2012 11:08:41 +0100
Message-ID: <20120621100841.GP4037@opensource.wolfsonmicro.com>
References: <1340301118-3800-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8558785434159294373=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0FB08104107
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2012 10:47:30 +0200 (CEST)
In-Reply-To: <1340301118-3800-1-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8558785434159294373==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sk71+Upln2BLuDmg"
Content-Disposition: inline


--Sk71+Upln2BLuDmg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 21, 2012 at 01:51:58PM -0400, Scott Jiang wrote:
> Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>

Applied, but as I said last time you should use subject lines that match
up with the rest of the subsystem.

--Sk71+Upln2BLuDmg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP4vKiAAoJEBus8iNuMP3dqj8P/i3XX7C160kg/ukLOTdQyOKz
BfUztxQi7LoxsqBtfy98elb/+ikQtFbrvGEdi3U9MqULpjLW3bwVTdUIO3a8icGF
SeEBASKliu2X/crnoc8s0BfWzpnpafJsMfwlAOrux7hDujB8FJKxzQ5Q+Uby3zOa
NO6Tpi/jQdv7CSZEFd4SVv8JMh2XF+fPF5yraLFVnERcXZhcWmSQxY763QSJzYNF
QnCtoNbnkqlPcSsNdq7SLGibm/YZ2J4xq77EFwNxSpSoH68ZUoQuD6kvm3klDWGz
Tl/k6YYQ6XY6GDJa9EmoBXzJSBxIGFpFOxp6r8+TtBQs1ZJXdzgY2jM+Sug5ZWHo
SWYs6LTY9o95Dm/fQjhM6SC/wAMlZo+h9LAZlCmN3YfiT8wG1/KOg0zhwskgMfJx
GbvFtr0pX8HBNsUpX/5dO/pUsm7R9KIcuQGNUaNs3mJjCCQJor4rZ+VHrphf7GtW
hE/yzUAGkbv9pIYDJUtU6RaJS4UHDTiHUbThdjVugkzWHiHQajPnaYk4ILNpK2yf
+hHxovVYbRjv5TngN6d5R7XczIoKbVgWk2KycWUCbwEcuab51RC8uDyEoUVAc0Ie
S0oVvByRQ50UZTQj214BcjYr5RV6/bw45bibv6rAFqEuatqGTdQzrcsa5NrPDb5p
JG/ALob5/y3hj9LHcZLJ
=goC6
-----END PGP SIGNATURE-----

--Sk71+Upln2BLuDmg--

--===============8558785434159294373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8558785434159294373==--
