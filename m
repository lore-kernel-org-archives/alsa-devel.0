From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: midisport 8x8
Date: Fri, 16 Apr 2004 10:28:29 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0404151924040.26803-100000@studcom.urz.uni-halle.de>
References: <1081962042.31370.8.camel@ianhome.meee.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <1081962042.31370.8.camel@ianhome.meee.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ian esten <deviant@custard.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

ian esten wrote:
> On Wed, 2004-04-14 at 10:00, Clemens Ladisch wrote:
> > What happens when you exchange the two 8x8 files in
> > /usr/share/usb/midisport?
>
> i get a working midisport 8x8! i can send it midi, and it shows up in
> /proc/asound/cards. thanks so much! so why is it incorrectly being
> reported as hardware version 1.21?

The reporting is correct, but I remembered that I wasn't sure which
file was which when I wrote the extracting program.  (This bug has now
been fixed.)


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
