From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Line6 USB driver in ALSA?
Date: Mon, 27 Feb 2006 21:18:41 -0500
Message-ID: <1141093122.3264.6.camel@mindpipe>
References: <200602261207.31050.grabner@icg.tu-graz.ac.at>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200602261207.31050.grabner@icg.tu-graz.ac.at>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Markus Grabner <grabner@icg.tu-graz.ac.at>
Cc: alsa-devel@lists.sourceforge.net, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-02-26 at 12:07 +0100, Markus Grabner wrote:
> 	Hi everybody!

Why don't you just submit your driver in its current form as a patch
against ALSA CVS, and we can go from there?  I'm a big fan of "release
early, release often".  If it's not too much work, you can break out the
parts that don't fit into the ALSA sources and submit those to LKML
separately.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
