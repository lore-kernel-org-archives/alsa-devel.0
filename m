From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: ALSA and SALSA install
Date: Thu, 6 Mar 2008 16:41:33 +0000
Message-ID: <200803061641.33445.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 97A4F2443D
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 17:12:40 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Following on from thread 'Problems with ALSA in embedded device', running code 
such as aplay with both ALSA and SALSA libs.

Is there a way to install both at the same time, so on a PC code can be 
compiled and experimented with first -lasound and then -lsalsa without 
alternately re-installing the libraries with make install?

Thanks

Alan
