From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: 2.5.7: First ALSA experience
Date: Wed, 3 Apr 2002 14:46:43 -0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204031147.g33BlOX16693@Port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8bit
Received: from Port.imtp.ilyichevsk.odessa.ua (167.imtp.Ilyichevsk.Odessa.UA [195.66.192.167] (may be forged))
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA24452
	for <alsa-devel@alsa-project.org>; Wed, 3 Apr 2002 13:50:05 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

Hi ALSA developers,

Congratulations with inclusion ALSA into 2.5, good work!

I successfully configured ALSA and now my box can play MP3
under Linux (was never able to do it in 2.4)!

BTW, I see in the logs:

Apr  3 14:05:54 manta kernel: ALSA cs4231_lib.c:344: cs4231_mce_down - auto calibration time out (1)
Apr  3 14:05:54 manta kernel: ALSA cs4231_lib.c:344: cs4231_mce_down - auto calibration time out (1)
Apr  3 14:10:26 manta kernel: ALSA cs4231_lib.c:344: cs4231_mce_down - auto calibration time out (1)
Apr  3 14:10:51 manta last message repeated 3 times

Is it harmful?
--
vda
