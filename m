From: "thewade" <pdman@aproximation.org>
Subject: Re: Alsa and hdspmixer segfault
Date: Fri, 1 Oct 2004 12:14:30 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410011814.i91IEUmY001683@sanctuary.aproximation.org>
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

> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 182894123680 (LWP 1231)]
> 0x0000003092b6d075 in cb2 () from /usr/lib64/libfltk.so.1.1
> 
> Should I rebuild fltk?

My fltk is:
fltk-1.1.4-1.1.fc2.dag.x86_64.rpm
fltk-devel-1.1.4-1.1.fc2.dag.x86_64.rpm
(The best/only rpms I could find. Ive tried the source
but I had problems I think, though Ive forgotten them now)
fltk-1.1.5rc2
fltk-1.2.x (CVS I think)
fltk-2.0.x (CVS I think)

And my arch is:
AMD64 Fedora Core 3 test 1 2.6.9-rc3 standard kernel.

Thanks again!
-thewade


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
