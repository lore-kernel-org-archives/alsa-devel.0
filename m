From: Attila Konietzka <attilakonietzka@gmx.net>
Subject: Maybe a bug with cmipci cmi8738 sound chip
Date: Sun, 12 Oct 2003 22:42:45 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031012204245.GA909@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello.
I write to you because nobody really on the alsa-user mailing list could
help me solve my problem, which is related to the cmi8738 on-board soundcard 
on my asus mainboard. Currently i am using the alsa-modules 0.9.6 version
available for the pre-made kernel-image 2.4.22 on debian.
My Problem is mainliy with the mic boost, in that it's effect is only on the
speakers level and the corresponding and resulting mic sensitivity if mic
boost is turned on.
However the record level remains unaffected by the activation of mic boost.
This is especially a problem for me, because my head-set requires this mic
boost to be turned on in order for the microphone signal to be send out in a
reasonable signal strength through my voice-chat program.
Also the normal sound-recording through ec command-line is affected by this
problem.
All corresponding volume sliders (mic, mic capture) are turned to maximum,
and the mic as center/lfe is turned off. What can i do?
I would like to hear from you, especially if you are aware of this problem, and
if there's currently anything i can do to fix this.
Regards, Attila.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
