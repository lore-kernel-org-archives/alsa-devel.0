From: Paul Davis <pbd@op.net>
Subject: hammerfall dsp driver progress report
Date: Thu, 2 May 2002 20:39:21 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205030039.g430dLa19431@op.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id CAA23201
	for <alsa-devel@alsa-project.org>; Fri, 3 May 2002 02:38:11 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org, linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

for those who keep track of such things, this evening i managed to get
the driver for the Hammerfall DSP to compile. testing will begin
tomorrow. its very similar to the Hammerfall driver, but different
enough that for now at least, it will always be a distinct module.

i am still waiting for info from RME about MIDI I/O and how to read
the lock/sync status information, as well as few other things that
have moved from register to register.

--p


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
