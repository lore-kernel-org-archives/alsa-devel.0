From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 021/102] ASoC: ssm2602: Omit superfluous
 elements in input select array
Date: Thu, 20 Feb 2014 10:20:35 +0900
Message-ID: <20140220012035.GG2669@sirena.org.uk>
References: <1392723422-12689-1-git-send-email-tiwai@suse.de>
 <1392723422-12689-6-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0578039993414154271=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A6E4265375
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:20:42 +0100 (CET)
In-Reply-To: <1392723422-12689-6-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0578039993414154271==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kSXt6YJnmi2/wVHJ"
Content-Disposition: inline


--kSXt6YJnmi2/wVHJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:36:56PM +0100, Takashi Iwai wrote:
> The array contains too many elements although it should have only
> two.

Applied, thanks.

--kSXt6YJnmi2/wVHJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBVhZAAoJELSic+t+oim9eeUP/0MIV24hgle3s/EusZgprBEr
Ed3t/Jx1a2qbdgXELQ/A+fNDcQ1gNgiqi8lT4Ch1qD/cy7epiGbyWSbUs+4OkvHx
NKtEu3bpA5XNrYiY6yOHzGoRMM388APiDCijH+Laz7aH8W6sBW0QmQcgcwwaWfvO
xbDAGgk6ykdk3PZKwM6Eoj+ks3iUuQKn7OnR7vRGGd/NTeL8WuTeQ38j3L0T7GiB
ycYiviS2yTlyJHVkJQunHJomLmqcKFXILhxPr+f8qQrQWoYcAIa6sCQZhsCVMfFB
PliPauxWyiIr23mkEwrdtw9UTXFHAMmDUhf/JCLmiwZpru9s+twrwSIQHkqYlalK
joKXqO++0Rg2evCGR4sc4GTg+GaMsVx5+yaOqCZ9rwY+b+pICkqWPDe/PBkgr+Dd
adMbc2VZVQicX1GAC+77SPbc5Vu4g7YuspuqCU7l1KL0ygF860Xq/a2XjOp5J4RA
x8w0TTLkL52reWPKovAzo1tx00kO9Jtwz19mX1xRHr/hUp3fc85CrZbruuMFow1v
iD5ariKWWMHJ3T7o0aYhjruX5MKaMU7rdbgZuyKPEBTGl+7xpLHyppSfWzZwH8CM
JV9jEt/2+nTmPhLT8Smt8PEkLa7rEPfJFSj01B8F6aqW7AXSW0YfKu1alh8lFdH/
v3a/1IYG6KJjQ7YOHydN
=Mp4T
-----END PGP SIGNATURE-----

--kSXt6YJnmi2/wVHJ--

--===============0578039993414154271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0578039993414154271==--
