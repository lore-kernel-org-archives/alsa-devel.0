From: Daniel T Chen <crimsun@fungus.sh.nu>
Subject: Re: More notes on HD-audio driver
Date: Wed, 10 Dec 2008 18:44:17 -0800
Message-ID: <49407E81.7060905@fungus.sh.nu>
References: <s5hmyf4cei7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ns1.mcdownloads.com (ns1.mcdownloads.com [216.239.132.98])
	by alsa0.perex.cz (Postfix) with ESMTP id CF0462449A
	for <alsa-devel@alsa-project.org>; Thu, 11 Dec 2008 03:44:23 +0100 (CET)
In-Reply-To: <s5hmyf4cei7.wl%tiwai@suse.de>
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

On 12/10/2008 06:05 AM, Takashi Iwai wrote:
>
> Comments, corrections and additions are appreciated.

Thanks for this document!  In the Power-Saving section, the path
/sys/modules/snd_hda_intel/parameters/power_save seems actually to be 
/sys/module/snd_hda_intel/parameters/power_save in 2.6.28-rc7 (no s in 
module).
