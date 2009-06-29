From: Martin Egge <mailinglists@martin.egge.info>
Subject: Re:
 =?iso-8859-15?q?Samsung_P50_Heaphone_Jack-Sense_not_?=
 =?iso-8859-15?q?working_with=09latest_ALSA?=
Date: Mon, 29 Jun 2009 08:43:05 +0200
Message-ID: <200906290843.06029.mailinglists@martin.egge.info>
References: <200906231425.47946.mailinglists@martin.egge.info>
	<200906250835.15497.mailinglists@martin.egge.info>
	<s5hiqikn6uj.wl%tiwai@suse.de>
	(sfid-20090625_085651_193723_71F458B0)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4999784287694585627=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 333EC103806
	for <alsa-devel@alsa-project.org>;
	Mon, 29 Jun 2009 08:43:14 +0200 (CEST)
In-Reply-To: <s5hiqikn6uj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============4999784287694585627==
Content-Type: multipart/signed;
  boundary="nextPart10224404.sQk4VFM8K2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart10224404.sQk4VFM8K2
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Takashi,

Am Donnerstag 25 Juni 2009 schrieb Takashi Iwai:
> At Thu, 25 Jun 2009 08:35:08 +0200,
>
> Martin Egge wrote:
> [...]
> > So, what went wrong?
>
> You must have saved the patch file wrongly.  Maybe your MUA broke
> text lines badly.

It seems that my webmail interface (Squirrelmail) has messed up spaces and=
=20
tabulators.

> Below is an attachment of the same patch.  Try this again.

Great Thanks. This time I could apply the patch. The patch has solved my=20
problem.


Martin

--nextPart10224404.sQk4VFM8K2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpIYnkACgkQVG/GfU56d2zIMwCfQrX5A7QWjoGiBER5nJl+y0kA
x6wAnRJuwcXxTg4u5G2kaTUojI1OkXPr
=yEsY
-----END PGP SIGNATURE-----

--nextPart10224404.sQk4VFM8K2--

--===============4999784287694585627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4999784287694585627==--
