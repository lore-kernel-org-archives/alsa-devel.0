From: Torrey Hoffman <thoffman@arnor.net>
Subject: ice1712 driver broken in 2.6.1-mm kernels
Date: Tue, 20 Jan 2004 13:22:46 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074633766.6579.2.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from devil.servak.biz (devil.servak.biz [209.124.81.2])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA29822
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2004 22:26:43 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Development <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

You may already know this, but the ice1712 driver doesn't work in Andrew
Morton's 2.6.1-mm? kernels which include the latest ALSA updates.

Tested with an M-Audio Audiophile 24/96. 

2.6.1-vanilla works, so does the 2.4 Fedora Core 1 kernel with ALSA
drivers from FreshRPMs.

Thanks!

-- 
Torrey Hoffman <thoffman@arnor.net>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
