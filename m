From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: help needed on how to autoload snd-usb-midi
Date: Thu, 17 Oct 2002 10:01:31 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0210170959320.23026-100000@studcom.urz.uni-halle.de>
References: <200210161849.29189@advent.drealm.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200210161849.29189@advent.drealm.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter L Jones <peter@drealm.org.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Peter L Jones wrote:
> On Wednesday 16 Oct 2002 12:19, Clemens Ladisch wrote:
> > It turns out there isn't any real advantage over a rawmidi driver, so I
> > think I'll change the driver to use rawmidi in the next few days.
>
> Will this affect the code used when I'm playing (with) my USB MIDI keyboard?
> (i.e. do I need to test it? ;-) )

In theory, no.
(In theory, there is no difference between theory and practice. :-)


Regards
Clemens



-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
