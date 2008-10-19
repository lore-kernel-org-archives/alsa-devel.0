From: William Pitcock <nenolod@sacredspiral.co.uk>
Subject: Re: Backported sbxfi driver (UNTESTED!)
Date: Sun, 19 Oct 2008 14:47:31 -0500
Message-ID: <1224445651.4088.68.camel@petrie.sacredspiral.co.uk>
References: <s5hy70xsl46.wl%tiwai@suse.de> <48F86293.90205@gmail.com>
	<s5hhc7bzgf4.wl%tiwai@suse.de> <48F86606.9070108@gmail.com>
	<s5h8wsnzfcu.wl%tiwai@suse.de> <48F9B51C.1040505@nostalgicnetworxx.org>
	<s5h3aiu2b9j.wl%tiwai@suse.de>
	<1224349819.4088.25.camel@petrie.sacredspiral.co.uk>
	<1224350224.4088.28.camel@petrie.sacredspiral.co.uk>
	<s5hej2dui9t.wl%tiwai@suse.de>
	<5501535d0810191107g5df3d71flee4c6db9a7c35b3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2612309896194935509=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carpathia.dereferenced.org (carpathia.dereferenced.org
	[64.71.161.129]) by alsa0.perex.cz (Postfix) with ESMTP id B3B47243BC
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Oct 2008 21:47:50 +0200 (CEST)
In-Reply-To: <5501535d0810191107g5df3d71flee4c6db9a7c35b3b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bjoern Olausson <lkmlist@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2612309896194935509==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-jVkGnaRDARV7HVgMXxB4"


--=-jVkGnaRDARV7HVgMXxB4
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Nothing in the X-Fi drive works yet.

William

On Sun, 2008-10-19 at 20:07 +0200, Bjoern Olausson wrote:
> By the way, the frontpannel headphone does not work.
> Is it supposed to work?
>=20
> http://us.creative.com/products/product.asp?category=3D209&subcategory=3D=
669&product=3D16559
>=20
> (I Have this frontpannel but actually no X-RAM version of the X-Fi
> series, or at least I can't remember that it has X-RAM)
>=20
>=20
> 01:00.0 Multimedia audio controller: Creative Labs SB X-Fi
>         Subsystem: Creative Labs X-Fi Platinum
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 64 (1000ns min, 1250ns max), Cache Line Size: 16 bytes
>         Interrupt: pin A routed to IRQ 21
>         Region 0: I/O ports at 8c00 [size=3D32]
>         Region 1: Memory at eb800000 (64-bit, non-prefetchable) [size=3D2=
M]
>         Region 3: Memory at e4000000 (64-bit, non-prefetchable) [size=3D6=
4M]
>         Capabilities: [40] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>         Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
> Queue=3D0/0 Enable-
>                 Address: 0000000000000000  Data: 0000
>         Kernel driver in use: SB-XFi
>=20
>=20
>=20
> 01:00.0 0401: 1102:0005
>         Subsystem: 1102:0021
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dmedium
> >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 64 (1000ns min, 1250ns max), Cache Line Size: 16 bytes
>         Interrupt: pin A routed to IRQ 21
>         Region 0: I/O ports at 8c00 [size=3D32]
>         Region 1: Memory at eb800000 (64-bit, non-prefetchable) [size=3D2=
M]
>         Region 3: Memory at e4000000 (64-bit, non-prefetchable) [size=3D6=
4M]
>         Capabilities: [40] Power Management version 2
>                 Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-
>         Capabilities: [50] Message Signalled Interrupts: Mask- 64bit+
> Queue=3D0/0 Enable-
>                 Address: 0000000000000000  Data: 0000
>         Kernel driver in use: SB-XFi
>=20
> Kind regards
> Bjoern
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>=20

--=-jVkGnaRDARV7HVgMXxB4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBI+47ToB+26npOQg4RApRPAJ99AtJQ4Z6wMcc0YBZu51HXh6f6ggCfYpxs
+c8K+WpUcV6HSIrAYwpgqMM=
=BFl4
-----END PGP SIGNATURE-----

--=-jVkGnaRDARV7HVgMXxB4--


--===============2612309896194935509==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2612309896194935509==--
