From: alsa-devel@robdye.net
Subject: Re: Questions to HDSP users
Date: Wed,  4 Feb 2004 17:04:30 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1075943070.4021969e6b6db@scorpio.lunarpages.com>
References: <4017D54D.2020502@undata.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from scorpio.lunarpages.com (scorpio.lunarpages.com [64.235.234.122])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id CAA12584
	for <alsa-devel@alsa-project.org>; Thu, 5 Feb 2004 02:03:28 +0100
In-Reply-To: <4017D54D.2020502@undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Quoting Thomas Charbonnel <thomas@undata.org>:

> Hi,
> 
> In the process of debuging the problems some hdsp users are 
> experiencing, I reviewed almost every single line of code in the hdsp
> 
> driver, and there are things in there that were inherited from the
> old 
> rme9652 driver and that don't seem relevant anymore for the hdsp 
> (particularly now that hdspmixer is there).

No objection from me on the proposed changes.  BTW, I am using an
HDSP9652 with a version of ALSA I got from CVS last August or so, and
haven't had any problems for what I'm doing (basic multichannel record
and playback, and some MIDI).




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
