From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 033/102] ASoC: da7213: Use
	SOC_ENUM_SINGLE_DECL()
Date: Thu, 20 Feb 2014 11:16:51 +0900
Message-ID: <20140220021651.GL2669@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-6-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5779175059907359142=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 711F2265646
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 03:23:55 +0100 (CET)
In-Reply-To: <1392723517-12772-6-git-send-email-tiwai@suse.de>
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


--===============5779175059907359142==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rv5sqxueBXCmI1hw"
Content-Disposition: inline


--Rv5sqxueBXCmI1hw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2014 at 12:37:49PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.
>=20

Applied, thanks.

--Rv5sqxueBXCmI1hw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWWQAAoJELSic+t+oim918sP/j3hyoyIyHO/f/wBlejBQiDY
J6azeL6nnvpt3VTXRxGqAtFARpqRN8m5upOTjIoQWvSGNT+HGIPsgV/px1sGz3Nm
448CQHxFjHQEgAyNDDpMmAjmrogXCsYKJN4MfB1SKG3BPAxVT9hcAYysQn+/N1mm
jakUScjOThuFjuJzGMH3M0LjNp35V666ffp/CgK+rb6Th1tzEjpSd2ShuGgj3wrx
xuymlCpqRnB9+e+1QUR+uryyzf9Y/0Hw/M12qWg05UUAs2dEYlDNG79i3M1ImO6O
bByOrFkCd7iiwzzjWzr5q4gpnyqCgflTz+XLn3rqR1ZrXlM+9aZ7OO86hIe4rerD
vPCWXixFI91LGm9ZrQJykEbrwQPnAlGep+q1acJtn9Dog3kSunrA+NM5ScxCV/93
PnHT+EsFXdK7l0DNr7PCOjDIpQRkpzXOLG01i5rrPtptAFSjIv+CPhviVr+9zcMr
0zhrzOabCRYRrjR8qMAVIZF6NmGU/VTIPsthDT3gRjE5LgZQkgoaz2aN4rM3DVvZ
lZEbuA/7sH3NqRRv8wrtJ1VF8Ok/CkLpU/Jcs0MITNDPj5xq4THTBefLE7puuiW5
2OSfMGpLTI7oemgYAzxh8t3+HJIc7PFV62EgcjsnxinhuAxYfWB80tRAwqQnTODx
AtIM8OIILmc6kEBwkZir
=wrnl
-----END PGP SIGNATURE-----

--Rv5sqxueBXCmI1hw--

--===============5779175059907359142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5779175059907359142==--
