From: Timur Tabi <timur@freescale.com>
Subject: Re: Driver recovers from underrun in plain ALSA mode,
 but not in OSS emulation
Date: Tue, 04 Mar 2008 09:20:36 -0600
Message-ID: <47CD68C4.7070008@freescale.com>
References: <47C89BBB.7040706@freescale.com> <s5hbq5u6ag4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id CFF9E1037F6
	for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2008 16:20:49 +0100 (CET)
In-Reply-To: <s5hbq5u6ag4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> The question is whether OSS emulation really notices the underrun.
> More likely, it's caused by the difference of parameters.

Can you explain, please?  Which parameters could be different?

-- 
Timur Tabi
Linux kernel developer at Freescale
