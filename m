From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/13] ASoC: Intel: add pm support in sst
	ipc driver
Date: Tue, 24 Feb 2015 16:54:15 +0900
Message-ID: <20150224075415.GN6236@finisterre.sirena.org.uk>
References: <1423715405-4562-1-git-send-email-vinod.koul@intel.com>
 <1423715405-4562-11-git-send-email-vinod.koul@intel.com>
 <20150223154516.GG6236@finisterre.sirena.org.uk>
 <20150223165406.GD5208@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8659718146440948655=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 720C2260423
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 08:55:17 +0100 (CET)
Received: from e0109-106-188-129-221.uqwimax.jp ([106.188.129.221]
 helo=finisterre)
 by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
 (Exim 4.80) (envelope-from <broonie@sirena.org.uk>)
 id 1YQAKm-0000mX-7j
 for alsa-devel@alsa-project.org; Tue, 24 Feb 2015 07:55:13 +0000
In-Reply-To: <20150223165406.GD5208@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8659718146440948655==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OE5XN2KVoD5QaTkR"
Content-Disposition: inline


--OE5XN2KVoD5QaTkR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 23, 2015 at 10:24:06PM +0530, Vinod Koul wrote:

> Sure, I will resend the remaining 4 patches. I am not sure why they are conflicting.
> Btw where did you apply the 9 patches. I fetched your tree and see 3 in
> mark/fix/intel and not rest

topic/intel.  When I say I've applied things I've applied them locally,
that doesn't mean they're published (especially not when I'm travelling
and internet access can be spotty).

--OE5XN2KVoD5QaTkR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7C4nAAoJECTWi3JdVIfQE1AH/1TI+BlTPcmc9Vmlk0vgwDoy
13ou36SaLs8cuS458/o2HEOFFNtIVpEhdIEXnKFFHHnKsZrP3F5iinXOvwGceweD
NLwy+ujpMR4bTyGLMYYxxW02lcxNICg3o5/9IXRJWITwkqXICAYM70GPT/lZqgTF
bPCNw58Awgy9niXY1pix6hXo8weBDkztbLueX5cVbupY4x+qBz3xgjkXuQ82EZUR
i4bCsoESsAV/2gi1DYtRhDmC8+aBjVlFQe5GjvQivb1Q4fwatp/t4MhSNy333ISs
sFu4n7R55EAwvAHQ8zsc9iX7haNGuPUeU2u+TwII7KZQFcRKwJ7klbGX6ZYQNeA=
=QMeC
-----END PGP SIGNATURE-----

--OE5XN2KVoD5QaTkR--

--===============8659718146440948655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8659718146440948655==--
