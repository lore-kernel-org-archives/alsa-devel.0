From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: Trigger wm_hubs series update
 startup off a separate flag
Date: Thu, 23 Jun 2011 13:17:12 +0100
Message-ID: <4E032EC8.5070707@ti.com>
References: <1308745217-21062-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 4BCA610384C
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Jun 2011 14:17:18 +0200 (CEST)
In-Reply-To: <1308745217-21062-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 22/06/11 13:20, Mark Brown wrote:
> Allowing the two to be used independently.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8993.c  |    1 +
>  sound/soc/codecs/wm8994.c  |    1 +
>  sound/soc/codecs/wm_hubs.c |    3 +--
>  sound/soc/codecs/wm_hubs.h |    1 +
>  4 files changed, 4 insertions(+), 2 deletions(-)
> 

Both

Acked-by: Liam Girdwood <lrg@ti.com>
