From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Work around allmodconfig failure
Date: Thu, 28 Apr 2011 14:32:11 +0100
Message-ID: <1303997531.3508.8.camel@odin>
References: <1303984727-14401-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 8DCD4103819
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 15:32:17 +0200 (CEST)
Received: by wwf26 with SMTP id 26so2401526wwf.20
	for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2011 06:32:17 -0700 (PDT)
In-Reply-To: <1303984727-14401-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Thu, 2011-04-28 at 10:58 +0100, Mark Brown wrote:
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  include/sound/soc.h   |    3 +++
>  sound/soc/soc-core.c  |    4 ++++
>  sound/soc/soc-utils.c |    6 ++----
>  3 files changed, 9 insertions(+), 4 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
