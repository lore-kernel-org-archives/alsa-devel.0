From: Manel Clos <manelclos@gmail.com>
Subject: M-audio Delta Audiophile 192 drivers
Date: Wed, 12 Dec 2007 16:24:08 +0100
Message-ID: <475FFD18.3040103@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by alsa0.perex.cz (Postfix) with ESMTP id 06899103853
	for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2007 16:26:24 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id q2so591535uge.50
	for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2007 07:26:24 -0800 (PST)
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

Hi all!

We purchased a M-audio Delta Audiophile 192, which uses the ICE1724
chipset. Using Ubuntu gutsy 7.10 and alsa 1.0.14. PCM is working, but as
soon as we start Rosegarden the complete system hangs (SysRq doesn't
even work). Also, the input of the card is not shown in gnome-mixer.

Is there anything we can do to help the development of the driver? We
are able to compile kernel + patches, do C programming, test PCM, Midi...

Thanks in advance!
