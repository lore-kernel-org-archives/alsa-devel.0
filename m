From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Compile errors with latest alsa releases
Date: Tue, 24 Feb 2004 18:59:13 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0402241845030.5168-100000@studcom.urz.uni-halle.de>
References: <403A4DA9.8010408@comcast.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <403A4DA9.8010408@comcast.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: snookertb <snookertb@comcast.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

snookertb wrote:
> SND_CTL_READONLY does not appear to be declared anywhere.

It's defined in alsa-lib/include/control.h.  You have to install the
alsa-lib package before compiling alsa-utils and alsa-tools.

> Are you part of the alsa development team?

SourceForge says no, the bugtracker says yes.  :-)


Regards,
Clemens




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
