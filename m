From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH] ASoC: fsl: Disable SSI in trigger() if
 RE/TE are both cleared
Date: Fri, 12 Jul 2013 07:11:35 -0500
Message-ID: <51DFF277.7020105@tabi.org>
References: <1373453034-21618-1-git-send-email-b42378@freescale.com>
 <20130711165401.GU24508@sirena.org.uk> <51DEE810.3090304@tabi.org>
 <20130712035732.GA27823@MrMyself> <51DF7F4F.90707@tabi.org>
 <20130712084328.GW24508@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay00.pair.com (relay00.pair.com [209.68.5.9])
 by alsa0.perex.cz (Postfix) with SMTP id 1179A2659C4
 for <alsa-devel@alsa-project.org>; Fri, 12 Jul 2013 14:11:39 +0200 (CEST)
In-Reply-To: <20130712084328.GW24508@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, linuxppc-dev@lists.ozlabs.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> Yes, that's why I just went ahead - you'd said recently that you'd be
> out of action for a while and not able to test anything.

Yeah, I'd rather you waited until I at least made sure it compiled.  Is 
there any way you can at least install the Freescale PowerPC SDK and do 
compile tests?  At least that way you won't have to wait for me for every 
little thing.

-- 
Timur Tabi
