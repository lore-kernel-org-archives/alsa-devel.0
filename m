From: Tony Vroon <tony@linx.net>
Subject: Re: [PATCH] Add fujitsu model for Realtek ALC269
Date: Thu, 06 Nov 2008 13:44:44 +0000
Message-ID: <1225979084.12866.5.camel@localhost>
References: <20081105204426.86C5710078@gold.linx.net>
	<s5hwsfhpd63.wl%tiwai@suse.de>
Reply-To: tony@linx.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5395578675581346045=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gold.linx.net (gold.linx.net [195.66.232.40])
	by alsa0.perex.cz (Postfix) with ESMTP id 2981224581
	for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2008 14:44:03 +0100 (CET)
In-Reply-To: <s5hwsfhpd63.wl%tiwai@suse.de>
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


--===============5395578675581346045==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-o99QCQN+9pO79PjMS1v2"


--=-o99QCQN+9pO79PjMS1v2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-11-06 at 07:43 +0100, Takashi Iwai wrote:
> Thanks for the patch.  But I already have added a fujitsu model for
> ALC269 recently for another Fujitsu machine.  Thus your patch obviously
> conflicts.

Duly noted. Could you share a codecgraph/codec file for that Amilo
please? Just to see how much overlap there is.
But based on the digital mic I might just have to rename mine.
ALC269_FUJITSU_LIFEBOOK, ALC269_LIFEBOOK or ALC269_ICH9?

> Could you re-create a patch based on the latest sound tree?

Assuming sound-2.6; have git-cloned this.

Regards,
Tony V.

--=-o99QCQN+9pO79PjMS1v2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkkS9MwACgkQp5vW4rUFj5rHTQCfZ0bcWMXMmlSYvyd7REK6pYlI
DlEAn2FWTjAqJ/MYq44KK+XWWeqshcdE
=MAQ+
-----END PGP SIGNATURE-----

--=-o99QCQN+9pO79PjMS1v2--


--===============5395578675581346045==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5395578675581346045==--
