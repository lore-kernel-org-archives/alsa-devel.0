From: Torrey Hoffman <thoffman@arnor.net>
Subject: Success with xine, 5.1 surround & ALSA
Date: Fri, 23 Jan 2004 16:53:58 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074905638.13428.205.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from devil.servak.biz (devil.servak.biz [209.124.81.2])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id BAA12735
	for <alsa-devel@alsa-project.org>; Sat, 24 Jan 2004 01:54:17 +0100
Received: from [64.122.104.99] (helo=[10.134.0.78])
	by devil.servak.biz with esmtp (Exim 4.24)
	id 1AkC3r-0004X6-Sm
	for alsa-devel@alsa-project.org; Fri, 23 Jan 2004 19:54:08 -0500
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

after all the bug reports and questions I've sent, I thought I'd send in
a success report - this was unexpectedly easy, and very nice to have
working.

Without much trouble, I got xine playing 5.1 channel surround sound
through the ALSA drivers for my onboard Intel ICH5 AC97 to Realtek
ALC650...  it all works... center & rear channels, downmixing if I
enable it, individual volume controls with gAlsaMixer for all the
surround channels...

Haven't tested the optical digital outputs yet... need to get a better
amp for that...

Woohoo!  

-- 
Torrey Hoffman <thoffman@arnor.net>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
