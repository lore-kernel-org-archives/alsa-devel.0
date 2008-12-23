From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [topic/asoc][PATCH]] ASoC: OMAP: Select OMAP pin
 multiplexing when using Nokia N810 ASoC drivers
Date: Tue, 23 Dec 2008 10:08:52 +0200
Message-ID: <20081223100852.67fbc2e7.jarkko.nikula@nokia.com>
References: <1230019562-6564-1-git-send-email-jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id A164E103817
	for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2008 09:09:02 +0100 (CET)
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id
	mBN88fKi005556
	for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2008 10:08:59 +0200
In-Reply-To: <1230019562-6564-1-git-send-email-jarkko.nikula@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 23 Dec 2008 10:06:02 +0200
Jarkko Nikula <jarkko.nikula@nokia.com> wrote:

> N810 bootloader muxes I2S pins for OMAP2420 EAC block while N810 ASoC
> drivers are using McBSP block so the kernel have to change configuration
> runtime.
> 
Grr... there were extra bracket in Subject. Will repost for easier
committing...


Jarkko
