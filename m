From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB audio kernel panic
Date: Tue, 11 May 2004 16:22:22 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405111618000.8179-100000@studcom.urz.uni-halle.de>
References: <409C94A8.6010703@boosthardware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <409C94A8.6010703@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick Shirkey wrote:
> Using the latest usb-audio code from cvs I get a kernel panic when
> loading the drivers.
>
> I'm running kernel-2.2.21 with gcc-2.95.4

Works fine with my 2.2.19(?).

ALSA 1.0.4 fixed some horrible bugs in the USB compatibility code for
2.2.x kernels.

Where exactly does this crash happen?


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
