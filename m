From: "thewade" <pdman@aproximation.org>
Subject: Re: Alsa and hdspmixer segfault
Date: Fri, 1 Oct 2004 12:19:40 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410011819.i91IJeUY001712@sanctuary.aproximation.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

> > Should I rebuild fltk?
>
> Not always, but what shows the stack trace?

How do I do that? Im not fimilar with gdb.

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 182894123680 (LWP 2494)]
0x0000003092b6d075 in cb2 () from /usr/lib64/libfltk.so.1.1
(gdb) trace
trace command requires an argument
(gdb) trace stack
Tracepoint 1 at 0x3092c92be0

Thanks!
-thewade


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
