From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Major Bug in Alsa 0.9  for over 1 year
Date: Fri, 25 Oct 2002 09:10:57 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210250910360.749-100000@pnote.perex-int.cz>
References: <22050.1035518578@www52.gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <22050.1035518578@www52.gmx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "kreuzritter2000@gmx.de" <kreuzritter2000@gmx.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 25 Oct 2002, kreuzritter2000@gmx.de wrote:

> modprobe snd-cs4236
> /lib/modules/2.4.19/kernel/sound/isa/cs423x/snd-cs4236.o: init_module: No
> such device

What's output from /proc/isapnp after this message?

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com



-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ads.sourceforge.net/cgi-bin/redirect.pl?sunm0004en
