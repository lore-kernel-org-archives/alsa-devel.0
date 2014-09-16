From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 1/1 linux-next] ASoC: cs35l32: remove
 second linux/slab.h inclusion
Date: Tue, 16 Sep 2014 14:21:55 -0500
Message-ID: <alpine.DEB.2.02.1409161418590.27378@heelrod>
References: <1410894151-6246-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0123.outbound.protection.outlook.com [65.55.169.123])
 by alsa0.perex.cz (Postfix) with ESMTP id BC3F7261A7F
 for <alsa-devel@alsa-project.org>; Tue, 16 Sep 2014 21:20:45 +0200 (CEST)
In-Reply-To: <1410894151-6246-1-git-send-email-fabf@skynet.be>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabian Frederick <fabf@skynet.be>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Paul Handrigan <Paul.Handrigan@cirrus.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


On Tue, 16 Sep 2014, Fabian Frederick wrote:

> linux/slab.h was included twice.
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
Acked-by: Brian Austin <brian.austin@cirrus.com>

Thanks,
