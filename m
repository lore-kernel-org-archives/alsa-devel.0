From: Jean-Marc Valin <jean-marc.valin@hermes.usherb.ca>
Subject: Re: No sound with Midiman Delta 1010LT
Date: 14 Apr 2002 13:40:59 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1018806069.1812.15.camel@idefix.homelinux.org>
References: <1018717194.5273.21.camel@idefix.homelinux.org>
	<056001c1e332$b551ee40$2900a8c0@burp>
	<1018755316.1852.23.camel@idefix.homelinux.org>
	<004801c1e3c2$dcd6a6a0$2900a8c0@burp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from VL-MS-MR004.sc1.videotron.ca (relais.videotron.ca [24.201.245.36])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA00869
	for <alsa-devel@alsa-project.org>; Sun, 14 Apr 2002 19:41:44 +0200
In-Reply-To: <004801c1e3c2$dcd6a6a0$2900a8c0@burp>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Tom Browne <tbrowne@tbrowne.demon.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I've taken a picture of the card, which you can find here:
http://speex.sourceforge.net/misc/1010LT.jpg

The card has 4 AK4524s and 15 small chips labeled as 5532 114B RJC. Also
a CS8427. Any useful info you can extract from that?

Thanks,

	Jean-Marc

Le dim 14/04/2002 =E0 10:44, Tom Browne a =E9crit :
> I imagine so... I think the 1010LT uses codec chips instead of separate A=
/D
> and D/As (take a look on the physical board).
>=20
> If they are similar to the AK4524s used on the Hoontech DSP24, you might =
try
> modifying the driver to make it think it's a DSP24...

--=20
Jean-Marc Valin, M.Sc.A.
LABORIUS (http://www.gel.usherb.ca/laborius)
Universit=E9 de Sherbrooke, Qu=E9bec, Canada
