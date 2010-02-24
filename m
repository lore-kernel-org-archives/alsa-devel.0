From: Felix Homann <fexpop@web.de>
Subject: Are there any quirks for getting mixers on USB audio
	devices working?
Date: Wed, 24 Feb 2010 19:37:36 +0100
Message-ID: <4B8571F0.3090906@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp188.webpack.hosteurope.de (wp188.webpack.hosteurope.de
	[80.237.132.195])
	by alsa0.perex.cz (Postfix) with ESMTP id CE1582446F
	for <alsa-devel@alsa-project.org>; Wed, 24 Feb 2010 19:37:47 +0100 (CET)
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

Hi,

I'm still trying to get a M-Audio Fast Track Ultra 8R (FTU8R) working. 
Searching through the USB Device Class Definition for Audio devices and 
comparing with the findings and logs I've posted recently, it seems to 
me that the mixer on the FTU8R is controlled in a pretty much standard 
USB fashion.

Unfortunately, it is not recognized as such. Are there any quirks to get 
such devices working?

Kind regards,

Felix
