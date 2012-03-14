From: Jonathan Andrews <jon@jonshouse.co.uk>
Subject: Re: Random process lockup on ARM board:
 alsa-lib-1.0.25, FUTEX_WAIT_PRIVATE
Date: Wed, 14 Mar 2012 13:18:49 +0000
Message-ID: <1331731129.9013.7.camel@jonspc>
References: <1329393691.6830.20.camel@jonspc>
	<1329512682.29051.1.camel@jonspc> <1329570128.6670.0.camel@jonspc>
	<4F400BBF.9020707@ladisch.de> <1329603022.1089.57.camel@jonspc>
	<4F41FC28.1070605@ladisch.de> <1329926198.22918.10.camel@jonspc>
	<4F45167A.6080706@ladisch.de> <1329933773.24266.44.camel@jonspc>
	<4F58736F.6010500@ladisch.de> <1331199625.22455.7.camel@jonspc>
	<4F588213.2030600@ladisch.de> <1331203724.22455.44.camel@jonspc>
	<4F589B58.6090203@ladisch.de> <1331214439.27232.12.camel@jonspc>
	<4F58C394.3020200@ladisch.de> <1331219690.30002.13.camel@jonspc>
	<s5h8vjbyuly.wl%tiwai@suse.de> <1331233549.2772.5.camel@jonspc>
	<4F591943.8040308@ladisch.de>
Reply-To: jon@jonshouse.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jonshouse.co.uk (unknown [91.84.151.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A4D91041D5
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 14:18:41 +0100 (CET)
In-Reply-To: <4F591943.8040308@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Just to finish this thread.

Maybe its not an alsa bug, but only happens to my code when using alsa.

Report filed here.
http://sourceware.org/bugzilla/show_bug.cgi?id=13845

Thanks,
Jon
