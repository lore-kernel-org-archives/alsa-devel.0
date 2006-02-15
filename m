From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: latency issue with mplayer ALSA plugin
Date: Wed, 15 Feb 2006 10:30:36 +0100
Message-ID: <20060215093036.GD10387@ifiu25.informatik.uni-halle.de>
References: <43F09D76.9060004@cendio.se>
 <20060214094741.GA8943@turing.informatik.uni-halle.de>
 <m2ek25ofhi.fsf_-_@vador.mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate2.uni-halle.de (mailgate2.urz.uni-halle.de [141.48.3.8])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DA05E1B6
	for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2006 10:30:48 +0100 (MET)
In-reply-to: <m2ek25ofhi.fsf_-_@vador.mandriva.com>
Content-disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thierry Vignaud <tvignaud@mandriva.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thierry Vignaud wrote:
> since we switched from pre7 to cvs (currently 20051220), i find
> mplayer's ALSA plugin has latency issues (underrun, ...) that he
> didn't have before on the same hw (athlon 2000+ with 256Mo ram).

There haven't been any changes in the ALSA plugin between pre7 and that
date that could affect latency.

Anyway, there have quite a few changes two days ago.


HTH
Clemens


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
