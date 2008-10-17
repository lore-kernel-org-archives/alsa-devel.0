From: Tony Vroon <tony@vroon.org>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Fri, 17 Oct 2008 11:00:19 +0100
Message-ID: <1224237619.4011.8.camel@localhost>
References: <s5hy70xsl46.wl%tiwai@suse.de>
	<loom.20081016T120322-319@post.gmane.org>	<s5h8wso3ejg.wl%tiwai@suse.de>
	<48F739F4.5070303@nostalgicnetworxx.org>	<48F74344.4090509@gmail.com>
	<s5hvdvs1wig.wl%tiwai@suse.de>	<48F74C91.7040708@gmail.com>
	<s5hprm01v3g.wl%tiwai@suse.de>	<48F75284.1040901@gmail.com>
	<s5hljwo1u01.wl%tiwai@suse.de>	<48F75700.5060102@gmail.com>
	<s5hfxmw1syu.wl%tiwai@suse.de>	<48F75892.8000209@gmail.com>
	<s5hbpxk1shh.wl%tiwai@suse.de>	<48F7855F.6060806@gmail.com>
	<s5hbpxj6902.wl%tiwai@suse.de>	<48F83013.4060203@gmail.com>
	<s5h7i8767zu.wl%tiwai@suse.de>	<48F8542E.30702@nostalgicnetworxx.org>
	<s5hwsg7zib3.wl%tiwai@suse.de> <48F85FE3.4060704@nostalgicnetworxx.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4988813654595134432=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ganymede.vroon.org (ganymede.vroon.org [195.66.242.11])
	by alsa0.perex.cz (Postfix) with ESMTP id 743FC10386A
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Oct 2008 12:01:31 +0200 (CEST)
In-Reply-To: <48F85FE3.4060704@nostalgicnetworxx.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Xarteras <xarteras@nostalgicnetworxx.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============4988813654595134432==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ga1aJP3gUd1ibi+bNMSD"


--=-ga1aJP3gUd1ibi+bNMSD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-10-17 at 09:50 +0000, Xarteras wrote:
> ossplay still crashes though and strace isn't of much use.
> Running ossplay causes a sys reset so fast the strace output cannot even=20
> be flushed to disk anymore, neverless be up long enough to read it on=20
> the screen.

A serial console may help you there, assuming you have two machines.

> Jan Wolf

Regards,
Tony V.

--=-ga1aJP3gUd1ibi+bNMSD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkj4YjMACgkQp5vW4rUFj5obygCfdJ9GJHOCZFklugSQmITbqu4m
jH8AoLcMtSZLwhhHjR8GpseVqb7p5QQW
=qRoK
-----END PGP SIGNATURE-----

--=-ga1aJP3gUd1ibi+bNMSD--


--===============4988813654595134432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4988813654595134432==--
