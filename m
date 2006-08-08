From: Jochen Voss <voss@seehuhn.de>
Subject: Re: GPIO connections for the M-Audio Revolution 5.1
Date: Tue, 8 Aug 2006 12:18:50 +0100
Message-ID: <20060808111850.GB2922@localhost.localdomain>
References: <20060807203113.GA5305@tarte.seehuhn.de>
	<s5hbqqvr0i6.wl%tiwai@suse.de> <20060808104015.GA20149@seehuhn.de>
	<s5h4pwnqydd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1488881869=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h4pwnqydd.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--===============1488881869==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Takashi,

On Tue, Aug 08, 2006 at 01:07:42PM +0200, Takashi Iwai wrote:
> > > > Why are the "not used" ones there?
> > >=20
> > > Why not? :)
> >=20
> > Because they are not used?
>=20
> But information is always good.  Actually, M-Audio mentioned that they
> might use these for a future model.

Oh, ok, then they should of course stay.

> Note that revo 7.1 has no volume control for the capture at all
> since its ADC chip (AK5380) has really no control.
>=20
> What ADC chip is on revo 5.1?

AK5365, according to the spec (page 21) this one has volume control.
Maybe recording is just a matter of putting the volume up on this
chip?

Many thanks,
Jochen
--=20
http://seehuhn.de/

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE2HMaf+iD8yEbECURAjZ9AJ9GrmcN6LXafB7XCrZMOI7Caq9PDgCgqpDg
oRIrf1lgzI99nvXCKprDvEQ=
=WH7G
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--


--===============1488881869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1488881869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1488881869==--
