From: Matt Flax <flatmax@ieee.org>
Subject: [off topic] WSOLA
Date: Wed, 15 Jan 2003 18:54:52 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030115075452.GC14261@ee.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.unsw.edu.au (smtp3.unsw.EDU.AU [149.171.96.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id IAA26199
	for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2003 08:18:24 +0100
Received: from smtp.unsw.edu.au (antivirus-02.services.comms.unsw.EDU.AU [149.171.193.81])
	by smtp3.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h0F7I9p07128
	for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2003 18:18:09 +1100 (EST)
Received: from maillationax ([149.171.37.159])
	by smtp.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h0F7Hte06950
	for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2003 18:18:09 +1100 (EST)
Received: from flatmax by maillationax with local (Exim 3.36 #1 (Debian))
	id 18YiNw-0003kx-00
	for <alsa-devel@alsa-project.org>; Wed, 15 Jan 2003 18:54:52 +1100
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello list,

I know that this is a off topic, however some of the developers of alsa 
also develop GPL audio apps.

WSOLA - which speeds and slows audio without altering pitch - just broke 
the real time barrier and has migrated to v3.0 'Mature' from 
v2.7 'Stable'. Essentially it processes audio six times faster then real 
time (800MHz CPU with coprocessor).

It is now ready for incorporation into audio apps which would like the 
added feature of a slider or knob for speeding up and slowing down the 
audio. Like I say, CPU utilisation is now very low.

It is possible to speed or slow the audio +-100% without too much 
distortion to the sound content.

Matt
-- 
http://mffm.darktech.org

WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
Vector Bass                : http://mffmvectorbass.sourceforge.net/
Multimedia Time Code       : http://mffmtimecode.sourceforge.net/


-------------------------------------------------------
This SF.NET email is sponsored by: Take your first step towards giving 
your online business a competitive advantage. Test-drive a Thawte SSL 
certificate - our easy online guide will show you how. Click here to get 
started: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0027en
