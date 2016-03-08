From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/9] ASoC: wm*: Fix enum ctl accesses
Date: Tue, 8 Mar 2016 09:02:56 +0000
Message-ID: <20160308090256.GF1490@localhost.localdomain>
References: <1456765278-5435-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 5045A2605C6
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 10:02:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1456765278-5435-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 29, 2016 at 06:01:09PM +0100, Takashi Iwai wrote:
> Hi,
> 
> here is a patchset for correcting the wrong access types to the enum
> ctl values in various wm* codec drivers.
> 
> I didn't put Cc to stable.  If they might be used for 64 bit
> architectures, it's a real problem.  In that case, feel free to put Cc
> to stable.
> 
> 
> thanks,
> 
> Takashi
> 
> ===

For the whole series:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
