From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: status pointer's problem with dmix.
Date: Thu, 18 Sep 2003 10:10:27 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200309181410.h8IEARdE017529@oud>
References: <3F69A98B.5020106@superbug.demon.co.uk>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 18 Sep 2003 13:48:11 BST."
             <3F69A98B.5020106@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Jaroslav Kysela <perex@suse.cz>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>The problem is that my application relies on a correct "delay" value, so 
>that it can use it to keep sound/video in sync.

although i think that the dmix plugin should work correctly, i would
be suprised, no, lets just say pleasantly suprised, if you could get
perfect sound/video sync using it. otoh, i don't recall enough of
jaroslav's description of how it worked at ZKM to really judge that.

i suspect its a bit like trying to an audio interface with a "sloppy"
hardware pointer. jaroslav will correct me, right jaroslav?

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
