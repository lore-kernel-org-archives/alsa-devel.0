From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: C++ and kernel development
Date: Thu, 19 Sep 2002 09:02:47 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0209190901450.826-100000@pnote.perex-int.cz>
References: <5.1.1.6.1.20020919000017.4326a3f0@pop.alternex.com.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5.1.1.6.1.20020919000017.4326a3f0@pop.alternex.com.br>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Haroldo Gamal <gamal@alternex.com.br>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 19 Sep 2002, Haroldo Gamal wrote:

> Hi Sirs,
>=20
> =09with the great help from my new friend Alfonso Acosta, who lend me a=
=20
> machine installed with a Darla 24. I started to develop  a driver  for th=
is=20
> card. I heard some time before about the difficulties of programming kern=
el=20
> modules using  C++. The  code made available by echo is written using C++=
,=20
> but do not use exceptions. In my opinion it would be easier to construct=
=20
> the driver using echo=B4s original code.  I would like to get some opinio=
ns=20
> about this... I prefer do not waste efforts trying to make c++ works  whe=
re=20
> it could=B4nt! I=B4ve have started the code writting the initial part  th=
at can=20
> not be written in C++.

I've not seen any piece of the kernel code written in C++, so I suggest to=
=20
use C.

=09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
