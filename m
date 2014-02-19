From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Correct regulator bypass error
	messages
Date: Wed, 19 Feb 2014 13:30:27 +0900
Message-ID: <20140219043027.GW2669@sirena.org.uk>
References: <1392739527-27392-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6477794674805362218=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BDF922652BF
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 08:53:19 +0100 (CET)
In-Reply-To: <1392739527-27392-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6477794674805362218==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0fs/EiH13ppNklOL"
Content-Disposition: inline


--0fs/EiH13ppNklOL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 04:05:27PM +0000, Charles Keepax wrote:
> The error messages for bypassing/unbypassing a regulator appear to be
> swapped round, this patch corrects these.

Applied, thanks.

--0fs/EiH13ppNklOL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBDNfAAoJELSic+t+oim91MMQAJm/HrPVPeQvL7it7sF9hnnT
IQqOTUC5nCfbyqcPmXYkbnT2DiQypIOx/7VH+GgI5540RALRaN4i8S86ZWOS3lep
AYxloENfcEBasQ+7FUxW5PCEoQvpXZG+0i9nlRAfEiYctTSIR8YGibjj2NmPz9SX
A9hsPdDoL4T66w4HH6K2Yw6is0wWubrUOtOCHb6wIU4X4VYLxdJa5p0qi/u93+r6
haalJb0UoBIhxxuuYv+vWUjU4HfT/RNdFUn/LheQlwQdyMIeXYYXeCZPJnyCshBa
iuqtQV8BBKvbLrsSyYdAFSGdFe0xfWKNKh7J2B+6cOvCn+cj2H6lHMAd2w2nGGtA
W49dhFVKYUjVkP8y8osB5AW3LSuPs72GmgteE2K2em21nuutbkEHHugM2GSpwEaS
ZkMFV6r41oIgT/R7EIa7fbsRrxFkYg8rCTQPTTXYsKPgJDENjx2JyzXtAXQC8lmc
uSlcjKerdRe6POJs4zUbt03mfU16yHhnqr5MtuokYJ5SBB+kCJxXMNkNgTGfafLo
DFrcrxGtLizoPe4gUa25mG22lrJg1RVP4CeuU2Z3pTBEjn+0bTjUovdQU61uMH29
NXJOOWWc+HKQCcTIsbSlqF3lbaV/iFjq0x+dV5pz7Ye1Z86BinTdLwrferwgtFkg
Rr4N/NL2V/XSpUL2KFJu
=127Z
-----END PGP SIGNATURE-----

--0fs/EiH13ppNklOL--

--===============6477794674805362218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6477794674805362218==--
