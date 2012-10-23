From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] [v2] ASoC: add support for the Freescale /
 iVeia P1022 RDK reference board
Date: Tue, 23 Oct 2012 00:35:56 +0000
Message-ID: <6AE080B68D46FC4BA2D2769E68D765B708108806@039-SN2MPN1-023.039d.mgd.msft.net>
References: <1350068958-1162-1-git-send-email-timur@freescale.com>
 <20121022152050.GO4477@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 by alsa0.perex.cz (Postfix) with ESMTP id 3E2F926526E
 for <alsa-devel@alsa-project.org>; Tue, 23 Oct 2012 02:36:02 +0200 (CEST)
In-Reply-To: <20121022152050.GO4477@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <FED37C0593C7614D855C81A303C775FF@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> Applied, thanks.  It would be nice to move over to more modern bindings
> for new boards though.

I understand, but the P1022RDK is very similar to the P1022DS.  I really 
didn't want to put that much effort into supporting it, since it's not 
sold by Freescale.

I'll use the new binding for the next audio-enabled board we make.

-- 
Timur Tabi
Linux kernel developer at Freescale
