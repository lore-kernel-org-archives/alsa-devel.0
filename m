From: Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [REPOST][PATCH v4 3/4] ASoC: SAMSUNG: Modify I2S
 driver to support idma
Date: Wed, 20 Jul 2011 13:50:05 +0530
Message-ID: <CABb+yY1xautX8k1x6Zciu40cz+7+OfHWNjW4SK3y8ti9AhwrYg@mail.gmail.com>
References: <1311149233-24343-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 489441038AF
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jul 2011 10:21:02 +0200 (CEST)
Received: by fxh2 with SMTP id 2so1410032fxh.9
	for <alsa-devel@alsa-project.org>; Wed, 20 Jul 2011 01:21:02 -0700 (PDT)
In-Reply-To: <1311149233-24343-1-git-send-email-sbkim73@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sangbeom Kim <sbkim73@samsung.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 20, 2011 at 1:37 PM, Sangbeom Kim <sbkim73@samsung.com> wrote:
> Previously, I2S driver only can support system dma.
> In this patch, i2s driver can support internal dma too.
> IDMA h/w configuration is initialized on idma.c
>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> Acked-by: Liam Girdwood <lrg@ti.com>

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
