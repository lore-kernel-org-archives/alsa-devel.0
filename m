From: "M. Gagnon" <fire_void@hotmail.com>
Subject: Development Question
Date: Sat, 17 Mar 2007 15:27:29 -0400
Message-ID: <BAY120-F3AD6DD98410316B330D259C700@phx.gbl>
References: <mailman.0.1174159191.971.alsa-devel@lists.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <mailman.0.1174159191.971.alsa-devel@lists.sourceforge.net>
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

Hi, i am now trying to port an application to linux using Alsa. At some =

point, i have midi bytes as char* and i have to play them. This is exactly =

the same data you'd find in a file, expect that it's in memory instead. How =

is that possible?

If this is not possible, i could always take any help on playing midi using =

sequencers I looked at the docs, i found a few samples, but they seemed to =

be outdated and the one that could interest me segfaulted. After i debugged =

it and fixed the segfault, it played nothing... (and i'm sure my midi is =

configured correctly BTW, pmidi works and i also succeeded in getting singl=
e =

notes to play)

Thanks

_________________________________________________________________
Ne perdez pas de temps dans les files d=92attente=85 magasinez en ligne.  =

http://magasiner.sympatico.msn.ca


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
