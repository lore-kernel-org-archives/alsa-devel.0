From: Klaus-Peter Schrage <kpschrage@gmx.de>
Subject: Re: ALSA doesn't work with XMMS
Date: Tue, 20 Jan 2004 19:55:03 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <400D7987.3030702@gmx.de>
References: <1074549141.22882.71.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (imap.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id TAA26896
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2004 19:56:42 +0100
In-Reply-To: <1074549141.22882.71.camel@moria.arnor.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Torrey Hoffman wrote:

> If I configure the XMMS ALSA plugin to use the "plughw:0:0" device, it
> opens the device and begins playback, but I just get noise... a
> repetitive burst like a stuck CD player.

Others (and me) on the alsa-user list have reported this noise too with 
alsa 1.0.1, a 2.6 kernel and the ice1712 driver.
What about you when using the old driver that's inside the vanilla 2.6.1 
kernel (0.9.7)? I don't have this noise then.
Klaus



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
