From: Ville Herva <vherva@v.iki.fi>
Subject: ice1724 M-Audio Revolution 5.1 support?
Date: Mon, 17 Oct 2005 22:21:56 +0300
Message-ID: <20051017192155.GA16945@v.iki.fi>
Reply-To: alsa-devel@lists.sourceforge.net, v@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
=20
is support for M-Audio Revolution 5.1 planned? It appears quite similar t=
o
7.1. I tried the monkey-see-monkey-do approach, and simply added the devi=
ce
ID to the driver (see the attached patch against 2.6.14-rc4), but that
doesn't quite work - I get
=20
   alsa_setup(): Sample format not available for playback: Invalid argume=
nt
=20
thanks...


--
"Se oli kuin noituutta:  Ei pystytty k=E4sitt=E4m=E4=E4n, kuinka suurmieh=
i=E4kin
Gleb ivallaan sai itkem=E4=E4n!  Mursi muutamalla sanalla: lause tai kaks=
i!=20
H=E4nt=E4 alettiin kutsua teurastajaksi. " - YUP


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
