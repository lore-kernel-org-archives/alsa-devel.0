From: Xavier ALLAMIGEON <xavier.allamigeon@libertysurf.fr>
Subject: ymfpci : four speakers with OSS-emulation ?
Date: Tue, 12 Mar 2002 22:10:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <a6lqr0$f5m$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Received: from mail.libertysurf.net (mail.libertysurf.net [213.36.80.91])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA24116
	for <alsa-devel@alsa-project.org>; Tue, 12 Mar 2002 22:07:59 +0100
Received: from there (212.83.138.122) by mail.libertysurf.net (5.1.070)
        id 3C7EF02B002549D4 for alsa-devel@alsa-project.org; Tue, 12 Mar 2002 22:07:29 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

	Good evening, 
I have installed the alsa-driver0.9.0beta12 on my MDK8.1 (kernel 2.4.18), and 
my rear speakers work. For example with "aplay -Dhw:0,2 foo.wav".
Is this possible to use the four speakers together under alsa or under the 
OSS emulation, with a sound card based on the ymfpci modules ?
I know it works with a SBLive!. Besides, I have seen that there are 
interesting configuration files in /usr/share/alsa. What must I do if I want 
the changes of these files to take effect ?
Thanks for all !

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
