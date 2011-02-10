From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 1/3] ASoC: Convert WM8903 bias management
 to use snd_soc_update_bits()
Date: Thu, 10 Feb 2011 23:05:13 +0000
Message-ID: <1297379113.3313.48.camel@odin>
References: <1297349088-26820-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id C6D6324377
	for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2011 00:28:57 +0100 (CET)
Received: by wwi18 with SMTP id 18so3656114wwi.2
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 15:28:57 -0800 (PST)
In-Reply-To: <1297349088-26820-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2011-02-10 at 14:44 +0000, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/wm8903.c |   17 +++++++----------
>  1 files changed, 7 insertions(+), 10 deletions(-)
> 

All.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
