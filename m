From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Detecting alsa sequencer (dis)connects
Date: Tue, 14 May 2002 17:55:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E177ee9-0003uZ-00@bitone.upf.es>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from iuamtg.upf.es (iuamtg.upf.es [193.145.55.151])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id RAA28564
	for <alsa-devel@alsa-project.org>; Tue, 14 May 2002 17:57:04 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org


Hello,

I want to have aconnectgui automatically update when changes have
been mode in the alsa sequencer connections (for example by
aconnect, or new applications being launched, or an application
creating a new connection). What would be the correct way to do
this? Maybe a polling alsa sequencer function that will tell
me about changes?

Maarten

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
