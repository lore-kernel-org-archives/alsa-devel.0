From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Subject: [Fwd: [Alsa-user] VIA 8237 issues and problems]
Date: Sat, 12 Feb 2005 18:32:53 +0000
Message-ID: <1108233173.874.3.camel@bastov>
Reply-To: sergio@sergiomb.no-ip.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi=20
Fwd to alsa-devel can be more appropriated !
any information about this VIA 8237 ?
google around have a very few information and on alsa site either.

TIA,

-------- Forwarded Message --------
> From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
> Reply-To: sergio@sergiomb.no-ip.org
> To: alsa-user <alsa-user@alsa-project.org>
> Subject: [Alsa-user] VIA 8237 issues and problems
> Date: Sat, 12 Feb 2005 03:25:19 +0000
> Hi,
>=20
> After trying everything , no sound still on my desktop
> I with Fedora Core 3 , and even try install alsa-drive, lib, and utils
> 1.0.8 from sources.=20
>=20
> about:=20
> kernel: Please try dxs_support=3D1 or dxs_support=3D4 option
> kernel:          and report if it works on your machine.
>=20
> adding options snd-via82xx dxs_support=3D1 or dxs_support=3D4 doesn't h=
elp.
>=20
> system-config-soundcard give me this warning :=20
> Playing WAVE '/usr/share/system-config-soundcard/sound-sample.wav' :
> Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
> Warning: rate is not accurate (requested =3D 44100Hz, got =3D 48000Hz)
>          please, try the plug plugin (-Dplug:hw:0,0)
>=20
> alsamixer says:=20
>=20
> Card: VIA 8237
> Chip: C-Media Electronics CMI9761
>=20
> lspci:
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8374 P4X400 Host Controll=
er/AGP Bridge (rev 82)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
> 00:0b.0 Communication controller: Conexant HSF 56k HSFi Modem (rev 01)
> 00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAI=
D Controller (rev 80)
> 00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/=
VT823x/A/C PIPC Bus Master IDE (rev 06)
> 00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 C=
ontroller (rev 81)
> 00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 C=
ontroller (rev 81)
> 00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 C=
ontroller (rev 81)
> 00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 C=
ontroller (rev 81)
> 00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
> 00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [KT600/K8T=
800 South]
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/82=
35/8237 AC97 Audio Controller (rev 60)
> 00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (=
rev 78)
>=20
>=20
>=20
> TIA,
--=20
S=E9rgio M.B.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
