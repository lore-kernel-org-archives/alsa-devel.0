From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCHv2 0/4] Add ESAI & SPDIF Vybrid and LS1+
	support.
Date: Fri, 4 Apr 2014 15:46:50 +0800
Message-ID: <20140404074649.GB2599@MrMyself>
References: <1396595429-16629-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C009265726
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 10:02:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1396595429-16629-1-git-send-email-Li.Xiubo@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, festevam@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 04, 2014 at 03:10:25PM +0800, Xiubo Li wrote:
> Changes in V2:
> - Revise some issue from Nicolin Chen and Fabio Estevam.

You have my ACK for all of them.

Thanks,
Nicolin

> 
> 
> Xiubo Li (4):
>   ASoC: esai: use the precise definition of 'ret'.
>   ASoC: spdif: Sort the header files alphabetically.
>   ASoC: esai: Add VF610+ compatibles support.
>   ASoC: spdif: Add VF610+ compatibles support.
> 
>  sound/soc/fsl/fsl_esai.c  | 9 ++++++---
>  sound/soc/fsl/fsl_spdif.c | 9 +++++----
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> -- 
> 1.8.4
> 
> 
