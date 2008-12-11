From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Idea about the laptop speakers
Date: Thu, 11 Dec 2008 09:40:01 +0500
Message-ID: <ghq5l5$4ms$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 42179244C2
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 05:41:24 +0100 (CET)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LAdMT-00049U-4X
	for alsa-devel@alsa-project.org; Thu, 11 Dec 2008 04:41:21 +0000
Received: from 90.151.141.177 ([90.151.141.177])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 04:41:17 +0000
Received: from patrakov by 90.151.141.177 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 04:41:17 +0000
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

Hello developers,

some time ago, people complained that the sound came out from both the 
laptop speakers and headphones. While in many cases this is not 
desirable, I think this effect (when configurable via opening a 
different PCM) can be useful in the following situation.

Suppose that you have a laptop as your main working machine. The headset 
is always connected, but you are not always near the laptop (e.g., think 
better if you walk in the room). Then, you configure (by telling it to 
open different devices) your SIP softphone to play voice through 
headphones only, but play ringtones through both headphones and 
speakers. Thus, you can walk in the room without being afraid to miss a 
call.

Is the above proposal implementable?

-- 
Alexander E. Patrakov
