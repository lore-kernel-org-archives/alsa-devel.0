From: Susan Cragin <susancragin@earthlink.net>
Subject: alsa bug - Martel Electronics USB soundcard recording
 sampling rate not automatically detected
Date: Thu, 9 Aug 2018 11:11:35 -0400 (GMT-04:00)
Message-ID: <2109591296.3392.1533827496340@wamui-koala.atl.sa.earthlink.net>
Reply-To: Susan Cragin <susancragin@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from elasmtp-kukur.atl.sa.earthlink.net
 (elasmtp-kukur.atl.sa.earthlink.net [209.86.89.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B9B8C26791D
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2018 17:11:40 +0200 (CEST)
Received: from [209.86.224.158] (helo=wamui-koala.atl.sa.earthlink.net)
 by elasmtp-kukur.atl.sa.earthlink.net with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-SHA256:128) (Exim 4)
 (envelope-from <susancragin@earthlink.net>) id 1fnmbC-0006Jm-3F
 for alsa-devel@alsa-project.org; Thu, 09 Aug 2018 11:11:38 -0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


I run Dragon NaturallySpeaking through wine. 
The program works great with my old Logitech USB soundcard.

But I just bought a new state-of-the-art dragon-optimized USB soundcard and stenomask, and the correct sampling rate cannot be automatically selected. 

Under proc/asound the device is described as EarMicrophone

/tmp/alsa-info.txt.RjFRV2vThr
