From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [PATCH alsa-kernel] snd-hda-codec-realtek: Add
 quirk for Jetway NF92
Date: Tue, 29 Mar 2011 09:37:47 -0400
Message-ID: <20110329133747.GM29800@alittletooquiet.net>
References: <20110328184307.GJ29800@alittletooquiet.net>
	<s5h8vvys98q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6511491503507173576=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from storm.alittletooquiet.net (storm.alittletooquiet.net
	[67.23.28.199]) by alsa0.perex.cz (Postfix) with ESMTP id 4EEED103937
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Mar 2011 15:37:48 +0200 (CEST)
In-Reply-To: <s5h8vvys98q.wl%tiwai@suse.de>
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


--===============6511491503507173576==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9s922KAXlWjPfK/Q"
Content-Disposition: inline


--9s922KAXlWjPfK/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Tue, Mar 29, 2011 at 08:59:01AM +0200, Takashi Iwai wrote:
> At Mon, 28 Mar 2011 14:43:07 -0400,
> Forest Bond wrote:
> >=20
> > The Jetway NF92 mainboard works with model=3D3stack-6ch-dig.  Add a
> > quirk to automatically configure the codec accordingly.
>=20
> So, the auto-parser didn't work properly for your mobo?  How?

Please disregard my patch (see my e-mail to Paul for further explanation).

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--9s922KAXlWjPfK/Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk2R4KsACgkQRO4fQQdv5Ax8bgCgh0IhPO9bl/sCtCVvhVbZ0t2x
cJMAn1bcrZv8YhdGaTWnpnP7OPxUfMmk
=8n6k
-----END PGP SIGNATURE-----

--9s922KAXlWjPfK/Q--

--===============6511491503507173576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6511491503507173576==--
