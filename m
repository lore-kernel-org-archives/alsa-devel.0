From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: 1.0.4rc from cvs-head: snd-usb-usx2y still needs
 snd-hwdep....
Date: Wed, 31 Mar 2004 09:10:17 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403310910110.1950@pnote.perex-int.cz>
References: <200403310119.34195.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200403310119.34195.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 31 Mar 2004, Karsten Wiese wrote:

> ..., which is not built.
> this is for kernel 2.4.
> 
> /etc/asound/driver_args:
> --with-cards=via82xx,msnd-pinnacle,usb-audio,usb-usx2y,es1968 
> --with-kernel=/usr/src/linux-2.4 --with-debug=full --with-sequencer=yes

Fixed.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
