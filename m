From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] regulator: wm8350: Don't specify consumer
 supplies with struct device
Date: Thu, 02 Feb 2012 13:59:39 +0000
Message-ID: <1328191179.3974.8.camel@odin>
References: <1328190339-21718-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog104.obsmtp.com (na3sys009aog104.obsmtp.com
	[74.125.149.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AC53103CD9
	for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2012 14:59:43 +0100 (CET)
Received: by wgbdy1 with SMTP id dy1so1901287wgb.20
	for <alsa-devel@alsa-project.org>; Thu, 02 Feb 2012 05:59:41 -0800 (PST)
In-Reply-To: <1328190339-21718-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

On Thu, 2012-02-02 at 13:45 +0000, Mark Brown wrote:
> Very, very deprecated.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>  drivers/regulator/wm8350-regulator.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Liam Girdwood <lrg@ti.com>
