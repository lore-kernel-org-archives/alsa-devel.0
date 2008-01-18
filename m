From: Zsolt Barat <zsolt@softmonsters.com>
Subject: HDMI Status
Date: Fri, 18 Jan 2008 21:32:25 +0100
Message-ID: <47910CD9.8010604@softmonsters.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.softmonsters.com (softmonsters.com [213.239.220.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 60AEF2464A
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 21:32:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by mail.softmonsters.com (Postfix) with ESMTP id A0E5B6500DD
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 21:32:22 +0100 (CET)
Received: from mail.softmonsters.com ([127.0.0.1])
	by localhost (softmonsters.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 24794-04 for <alsa-devel@alsa-project.org>;
	Fri, 18 Jan 2008 21:32:18 +0100 (CET)
Received: from [192.168.10.15] (p57A0F306.dip.t-dialin.net [87.160.243.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "CAcert WoT User",
	Issuer "CA Cert Signing Authority" (verified OK))
	by mail.softmonsters.com (Postfix) with ESMTP id 4A10C6500DC
	for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2008 21:32:18 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

hi list,
since i don't got any response on the users list, i try it here.
i own a MSI board, K9AGM2, with north bridge S690G/690V and a as 
southbridge SB600. the hda-intel driver works perfectly for the most part.
i just want to ask, how complete is the support for hdmi-audio. it seems 
that the hdmi-hardware is at least detected since alsamixer shows me as 
chip: Generic 1002 ATI RS690/780 HDMI. is it also supposed to put out 
some audio? i couldn't test it cause of lack of hdmi-sound capable hardware.

best regards

zsolt
