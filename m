From: Tommi Sakari Uimonen <tuimonen@cc.hut.fi>
Subject: Re: arecord to support >2GB files?
Date: Wed, 27 Aug 2003 15:56:37 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.OSF.4.56.0308271548370.398158@kosh.hut.fi>
References: <Pine.LNX.4.44.0308271523250.9988-100000@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0308271523250.9988-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I guess the CVS doesn't update very rapidly. Since I last checked (5 mins
ago) aplay.c was dated Aug 7)

> Ecasound has support for LFS (compile with --with-largefile).

Is there also --with-96khz option? :)
If there is, or there will be soon (in two days), I'll change to that.

88200 would do fine also...

And about GUI's for ecasound, are there such that won't affect the
recording - I mean that the recording would be as "xrun free" as running
ecasound in console?


Tommi Uimonen


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
