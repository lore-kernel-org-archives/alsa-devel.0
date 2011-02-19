From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH v2] sound azt3328: hook up new emulated
 AC97 on AC97 patch side
Date: Sat, 19 Feb 2011 16:52:31 +0100
Message-ID: <20110219155231.GA26367@rhlx01.hs-esslingen.de>
References: <20110216231612.GB1638@rhlx01.hs-esslingen.de>
	<s5htyg2woh2.wl%tiwai@suse.de>
	<20110218234948.GB23066@rhlx01.hs-esslingen.de>
	<s5h1v34caq4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 531D024616
	for <alsa-devel@alsa-project.org>; Sat, 19 Feb 2011 16:52:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h1v34caq4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sat, Feb 19, 2011 at 04:20:19PM +0100, Takashi Iwai wrote:
> Applied this one, too.  Thanks.

Thanks a lot!

Now going to work on PA timer-based wakeup operation in several drivers
(azt3328, maestro3i, als4000, ...),
but I'll have to wait a bit due some pieces on the distribution side
(alsa 1.0.24 etc.) still missing.

Andreas
