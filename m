From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] USB MIDI as rawmidi
Date: Tue, 22 Oct 2002 08:47:53 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210220846380.14032-100000@studcom.urz.uni-halle.de>
References: <200210212230.07728@advent.drealm.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200210212230.07728@advent.drealm.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter L Jones <peter@drealm.org.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Peter L Jones wrote:
> On Monday 21 Oct 2002 16:15, Clemens Ladisch wrote:
> > This patch converts usbmidi to use rawmidi instead of sequencer devices.
>
> Sorry if this is a dumb question but what's the patch against?

current CVS

> Can I apply it against alsa rc-3 in 2.5.44?

Probably not, there have been other changes since rc3.


HTH
Clemens



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future of 
Java(TM) technology. Join the Java Community Process(SM) (JCP(SM)) 
program now. http://ad.doubleclick.net/clk;4699841;7576301;v?
http://www.sun.com/javavote
