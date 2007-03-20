From: "raghvendra misra" <raghvendramisra@gmail.com>
Subject: Re: Development Question
Date: Tue, 20 Mar 2007 07:28:15 +0530
Message-ID: <3412cfd30703191858t2a56e1c6uf4309358fa3e4f65@mail.gmail.com>
References: <1174293182.15615.1180145133@webmail.messagingengine.com>
	<BAY120-F107E83F9DDD0189BB6554C9C750@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <BAY120-F107E83F9DDD0189BB6554C9C750@phx.gbl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: "M. Gagnon" <fire_void@hotmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

unsubscribe

On 3/20/07, M. Gagnon <fire_void@hotmail.com> wrote:
>
> >What is the output of the program?
>
> 14:0 --> Midi Through Port-0
> 128:0 --> TiMidity port 0
> 128:1 --> TiMidity port 1
> 128:2 --> TiMidity port 2
> 128:3 --> TiMidity port 3
> pending events size: 28
> pending events size: 56
> pending events size: 84
> pending events size: 112
> pending events size: 140
> pending events size: 168
> pending events size: 196
> pending events size: 224
> pending events size: 252
> pending events size: 280
> pending events size: 308
> pending events size: 336
> pending events size: 364
> pending events size: 392
> pending events size: 420
> pending events size: 448
> BEFORE DRAIN: pending events size: 476
> AFTER DRAIN: pending events size: 0
> all events drained
>
> everything seems okay to me (i may not be adding the same number of notes=
 as
> in the sample i posted, and i have more console prints now, so small
> differences could appear from the code i posted)
>
> >What are the contents of /proc/asound/seq/queues and .../timers while it=
's
> >trying to play?
>
> i'm sorry, but despite some googling this still sounds esoteric to me. Any
> reference i could look at to know how to do this?
>
> thanks
>
> _________________________________________________________________
> Participez au concours Tourn=E9e Live Mobile d=E8s maintenant!
> http://www.concertmobilelive.ca
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share y=
our
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
