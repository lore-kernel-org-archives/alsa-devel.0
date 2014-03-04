From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/5] ASoC: kirkwood: prepare new Dove DT
 Kconfig variable
Date: Tue, 4 Mar 2014 12:03:14 +0800
Message-ID: <20140304040314.GC2411@sirena.org.uk>
References: <1393536486-3827-3-git-send-email-sebastian.hesselbarth@gmail.com>
 <1393662801-17950-1-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5825719562695934076=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A276B2656B4
 for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2014 05:03:38 +0100 (CET)
In-Reply-To: <1393662801-17950-1-git-send-email-sebastian.hesselbarth@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, alsa-devel@alsa-project.org, Jason Cooper <jason@lakedaemon.net>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============5825719562695934076==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5AMDinkw1evBROKu"
Content-Disposition: inline


--5AMDinkw1evBROKu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 01, 2014 at 09:33:17AM +0100, Sebastian Hesselbarth wrote:
> DT-enabled Dove will move over from ARCH_DOVE in mach-dove to MACH_DOVE in
> mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
> DT-only MACH_DOVE Kconfig.

This doesn't apply against current ASoC, please check and resend.

--5AMDinkw1evBROKu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFVB+AAoJELSic+t+oim95nwP/1uyEm3ESYlgB3peebEZKl1T
Pmqq4L8g/mE78JLRE5iLYbmIlDQ5KVVFRLHba4wG/ODNrobAAtYuGKPea9XcpHFA
a4HQknEjvfYa+Wx6Um2Dzq5OXXc0SoW66CLZON/1Zv5zfSO/2k8kv4RtV8w14mlL
/o0ybTWSthvWCw/xaNLEXlQc16xpLZAfApQexi62ykNAawE/K7V3j6ZC9PrzQomv
CG8hA0s/8EY3wWmB1KvUYY59qodKuzanP9vd68LzW/0mHUA8cACKlIzT0GFeNFW3
LAFYFk32Vt3lilcWBB580o6VOHLNDS/Xs+ALYy7UpUZffesGT+BsuIwB8gFSE3kT
0rSGgYTicKx4GBeFkjes4dm081SffHk7nwBjkUzWrk+n+0KgdKNUVHLXlUxAwBb+
NVy8tqouvd+xgq5GTwBBH43w+MQbGAPhHEzX7kjElIlMLwKfgUMt02+lvxALVgSP
3zM2bA3HZoTadvVck+V2Td7h6U+HSFZ+ZrNOiDfT2xkkhZI+ZdEp1uVs9NT1egWc
if4aljVYvCEXTo9UY4JXINa/de/N26UeHlKNRPCP0lOl2gdKoTSmHos+teRNUJgK
Qb5xzvu8Q6Ii1vRwbt3HowHAjunflqkTWCSvv7mPOtlAGks1bCrwVaU5mbzOu5PM
IXxhHOGb/p3FQBD6D4aM
=06RQ
-----END PGP SIGNATURE-----

--5AMDinkw1evBROKu--

--===============5825719562695934076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5825719562695934076==--
