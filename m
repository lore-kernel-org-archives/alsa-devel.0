From: "Hicks, Jamey" <Jamey.Hicks@compaq.com>
Subject: RE: UDA1341TS (iPAQ H3X00) sound driver for ALSA
Date: Wed, 10 Apr 2002 09:55:43 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a91gbb$k15$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Class: urn:content-classes:message
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Nicolas Pitre <nico@cam.org>
Cc: Kasparek Tomas <xkaspa06@stud.fee.vutbr.cz>, alsa-devel@lists.sourceforge.net, Linux-arm-kernel@lists.arm.linux.org.uk
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Nicolas Pitre [mailto:nico@cam.org]
> Sent: Wednesday, April 10, 2002 9:47 AM
> To: Hicks, Jamey
> Cc: Kasparek Tomas; alsa-devel@lists.sourceforge.net;
> Linux-arm-kernel@lists.arm.linux.org.uk
> Subject: RE: UDA1341TS (iPAQ H3X00) sound driver for ALSA
>=20
>=20
> On Wed, 10 Apr 2002, Hicks, Jamey wrote:
>=20
> >=20
> > I would prefer that the ALSA driver for the iPAQ have a=20
> different name
> > than the OSS driver for the iPAQ, since they have different=20
> interfaces. =20
> > How about h3600-alsa?
>=20
> No.  Please pick a relevant name.  H3600 is not the only=20
> device with an UDA1341 out there.

The alsa driver mentioned is iPAQ specific.  It would be useful to =
restructure it in the way the other SA11x0/UDA134x driver is structured.

Jamey
