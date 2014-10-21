From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/2] ASoC: s6000: Use snd_ctl_enum_info()
Date: Tue, 21 Oct 2014 15:24:38 +0200
Message-ID: <54465E96.5090706@metafoo.de>
References: <1413886496-19158-1-git-send-email-tiwai@suse.de>
 <1413886496-19158-2-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-024.synserver.de (smtp-out-024.synserver.de
 [212.40.185.24])
 by alsa0.perex.cz (Postfix) with ESMTP id C91C926049B
 for <alsa-devel@alsa-project.org>; Tue, 21 Oct 2014 15:24:37 +0200 (CEST)
In-Reply-To: <1413886496-19158-2-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@kernel.org>, =?ISO-8859-1?Q?Daniel_Gl=F6ckner?= <dg@emlix.com>
List-Id: alsa-devel@alsa-project.org

On 10/21/2014 12:14 PM, Takashi Iwai wrote:
> ... and reduce the open codes.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

There is another patch from a couple of days back which removes this driver, 
so I guess this patch can be dropped.
