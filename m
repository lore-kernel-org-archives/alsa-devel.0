From: Friedrich.Ewaldt@gmx.de
Subject: Terratec DMX XFire DSP
Date: Fri, 2 Aug 2002 09:44:25 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <10779.1028274265@www55.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx0.gmx.net (mx0.gmx.net [213.165.64.100])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id JAA01974
	for <alsa-devel@alsa-project.org>; Fri, 2 Aug 2002 09:45:10 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Benny,
regarding your cs46xx DSP and codec list:
AFAIK the Xfire card has got a CS4624 DSP, not a CS4630. The main (only?)
difference should be the processing power (CS4624: 255MIPS, CS4630: 420MIPS).
I think the CS4630 can handle AC3 input through S/P-DIF whereas the CS4624
does not (because of the proc. power?). AC3 out should be working with both
DSPs.
Are there any more differences you know of?
Is there any possibility for me to check the codec type of the Xfire card
e.g. under windows or by looking at the components on the cards?
regards
fritz_e

-- 
GMX - Die Kommunikationsplattform im Internet.
http://www.gmx.net



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
