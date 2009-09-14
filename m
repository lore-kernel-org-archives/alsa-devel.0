From: "Daniel L. Miller" <dmiller@amfes.com>
Subject: SPDIF with X-Fi
Date: Mon, 14 Sep 2009 14:22:32 -0700
Message-ID: <4AAEB418.2000005@amfes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.amfes.com (a.amfes.com [64.245.146.34])
	by alsa0.perex.cz (Postfix) with ESMTP id 16931243BB
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Sep 2009 23:22:34 +0200 (CEST)
Received: from mail.amfes.com (bubba.amfeslan.local [192.168.0.72])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.amfes.com (Postfix) with ESMTPSA id 55AEA11A5C4
	for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2009 14:22:33 -0700 (PDT)
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

Perhaps I'm going about this the wrong way (if so, please tell me), but...

My X-Fi card is now working with the new driver.  I am connected to my 
amplifier via a fiber optic cable.  Sending standard two-channel audio 
to the "front" alsa plug gets directed to the spdif output and sounds 
great.  But I want to have my full surround active - particularly for 
movies already encoded with dts and/or ac-3.

Thus far, I have not been able to get mplayer to send digital audio - I 
either get mplayer errors or silence.  Once, and only once, I got xbmc 
to work with digital settings - never since.  So I know it SHOULD be 
possible - I'm just missing something.

Is anyone getting this to work?
-- 
Daniel
